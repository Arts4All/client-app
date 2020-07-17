//
//  CanvasViewController.swift
//  Art4All
//
//  Created by Pedro Henrique Guedes Silveira on 06/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import UIKit
import SocketIO

class CanvasViewController: UIViewController, ConnectionSocketDelegate, ColorWheelDelegate {

    var canvasView = UIView()
    var numberOfLines: Int = 10
    var numberOfColumns: Int = 20
    var squareSize: Int = 80
    var grid: VisualGrid?
    var tiles: [VisualGridElement]?
    var paintColor: UIColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    var gestureRecognizer: UITapGestureRecognizer!
    var longPressRecognizer: UILongPressGestureRecognizer!
    let colorWheelView: ColorWheelView = ColorWheelView(frame: UIScreen.main.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInitalGrid()
        setNeedsFocusUpdate()
        updateFocusIfNeeded()
    }

    override func viewDidLayoutSubviews() {
    }

    func setupSocket() {

    }

    // MARK: - GRID
    func setupInitalGrid() {
        ConnectionSocket.shared.setupDelegate(delegate: self)

    }

    func setupGrid(_ numberOfColumns: Int, _ numberOfLines: Int, _ mapColors: MapColors) {
        self.view.addSubview(canvasView)

        grid = VisualGrid(numberOfColumns: numberOfColumns,
                          numberOfLines: numberOfLines,
                          squareSize: squareSize,
                          mapColors: mapColors)

        self.numberOfColumns = numberOfColumns
        self.numberOfLines = numberOfLines

        guard let grid = grid else {
            return
        }

        tiles = grid.tiles

        guard let tiles = tiles else {
            return
        }

        for tile in tiles {
            self.canvasView.addSubview(tile.node)
        }
        setupTilesAction()
        
        setupGestureRecognizer()

        // Constraints
        setupCanvasViewConstraints()
        setupGridConstraints()
        setupColorWheel()
        setupColorWheelContraints()

    }

    func setupCanvasViewConstraints() {
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            canvasView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            canvasView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: 0),
            canvasView.widthAnchor.constraint(equalToConstant: calculateCanvasWidth()),
            canvasView.heightAnchor.constraint(equalToConstant: calcutateCanvasHeight())
        ])
    }

    func setupGridConstraints() {
        guard let tiles = tiles else {
            return
        }
        for tile in tiles {
            let node = tile.node
            node.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                node.widthAnchor.constraint(equalToConstant: node.frame.width),
                node.heightAnchor.constraint(equalToConstant: node.frame.height),
                node.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor,
                                              constant: CGFloat(tile.xPositionOnCanvas)),
                node.topAnchor.constraint(equalTo: canvasView.topAnchor, constant: CGFloat(tile.yPositionOnCanvas))
            ])
        }
    }

    func setupTilesAction() {
        guard let tiles = tiles else {
            return
        }

        for (index, tile) in tiles.enumerated() {
            let node = tile.node
            node.tag = index
            self.gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentColorWheel))
            node.addGestureRecognizer(gestureRecognizer)
        }
    }

    func changeTileState(color: UIColor, position: (xPosition: Int, yPosition: Int)) {
        guard
            let nodeIndex = self.grid?.grid.findElementIndex(by: position.xPosition,
                                                             by: position.yPosition),
            let tiles = tiles
            else {
                return
        }
        let tile = tiles[nodeIndex]
        tile.changeTileState(state: .modified, newColor: color)
    }

    func calculateCanvasWidth() -> CGFloat {
        return CGFloat(numberOfColumns * squareSize)

    }

    func calcutateCanvasHeight() -> CGFloat {
        return CGFloat(numberOfLines * squareSize)
    }

    func setupGestureRecognizer() {
        guard let guardedTiles = tiles else {
            return
        }
        
        for guardedTile in guardedTiles {
            let node = guardedTile.node
            let nodeGesture = UILongPressGestureRecognizer(target: self, action: #selector(presentColorWheel))
            nodeGesture.minimumPressDuration = 0.5
            nodeGesture.allowableMovement = 100
            node.addGestureRecognizer(nodeGesture)
        }
    }

    func selectedColor(color: UIColor) {
          paintColor = color
    }
    
    func setupColorWheel() {
        view.addSubview(colorWheelView)
    }
    
    func setupColorWheelContraints() {
        colorWheelView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorWheelView.heightAnchor.constraint(equalToConstant: view.frame.size.height),
            colorWheelView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            colorWheelView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: self.view.frame.width),
            colorWheelView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
    }

    @objc func presentColorWheel() {
        UIView.animate(withDuration: 1.0, delay: 1.2, options: .curveEaseIn, animations:{ 
            NSLayoutConstraint.activate([
                self.colorWheelView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
        })
    }
    

    @objc func changeTileColor(sender: UITapGestureRecognizer) {

        guard
            let grid = grid,
            let node =  grid.getSelected(),
            let tile = node.visualGridElement,
            tile.hasBeenModified == false
            else {
                return
        }
        ConnectionSocket.shared.drawToServer(color: paintColor,
                                             (xPosition: tile.xPosition,
                                              yPosition: tile.yPosition))
    }

}
