//
//  CanvasViewController.swift
//  Art4All
//
//  Created by Pedro Henrique Guedes Silveira on 06/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import UIKit
import SocketIO

class CanvasViewController: UIViewController, ConnectionSocketDelegate {

    var canvasView = UIView()
    var numberOfLines: Int = 10
    var numberOfColumns: Int = 20
    var squareSize: Int = 80
    var grid: VisualGrid?
    var tiles: [VisualGridElement]?
    lazy var sideMenu = SideMenuView(frame: self.view.frame, delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(sideMenu)
        self.setupInitalGrid()
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

    @objc func changeTileColor(sender: Any) {

        guard
            let node = sender as? CanvasNode,
            let tile = node.visualGridElement,
            tile.hasBeenModified == false
        else {
            return
        }
        ConnectionSocket.shared.drawToServer(color: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1),
                                             (xPosition: tile.xPosition,
                                              yPosition: tile.yPosition))
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
}

extension CanvasViewController: SideMenuViewDelegate {
    func save() {
        print("save")
    }

    func transform() {
        print("transform")
    }

    func back() {
        self.navigationController?.popViewController(animated: true)
    }
}
