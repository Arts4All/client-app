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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInitalGrid()
        self.setupGestureRecognizer()
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
        
        // Constraints
        setupCanvasViewConstraints()
        setupGridConstraints()
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
            node.addTarget(self, action: #selector(changeTileColor(sender: )), for: .primaryActionTriggered)
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
        print(nodeIndex)
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
        let nodeGesture = UILongPressGestureRecognizer(target: self, action: #selector(presentColorWheel))
        guard let guardedTiles = tiles else {
            return
        }
        for guardedTile in guardedTiles {
            let node = guardedTile.node
            node.addGestureRecognizer(nodeGesture)
        }
    }
    
    func selectedColor(color: UIColor) {
          paintColor = color
    }
    
    @objc func presentColorWheel() {
        let colorWheelViewControler = ColorWheelViewController()
        self.navigationController?.present(colorWheelViewControler, animated: true, completion: nil)
    }
    
    @objc func changeTileColor(sender: Any) {
        
        guard
            let node = sender as? CanvasNode,
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
