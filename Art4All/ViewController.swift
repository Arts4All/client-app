//
//  ViewController.swift
//  Art4All
//
//  Created by Matheus Silva on 02/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import UIKit
import SocketIO

class ViewController: UIViewController {

    var canvasView = UIView()
    var numberOfLines: Int = 10
    var numberOfColumns: Int = 20
    var squareSize: Int = 80
    var grid: VisualGrid?
    var tiles: [VisualGridElement]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInitalGrid()
    }

    override func viewDidLayoutSubviews() {
        setupCanvasViewConstraints()
        setupGridConstraints()
    }

    func setupSocket() {

    }

    // MARK: - GRID
    func setupInitalGrid() {
        self.view.addSubview(canvasView)
        setupGrid()
        setupTilesAction()
    }

    func setupGrid() {
        grid = VisualGrid(rowSize: numberOfColumns, numberOfLines: numberOfLines, squareSize: squareSize)

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
                node.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor, constant: CGFloat(tile.xPositionOnCanvas)),
                node.bottomAnchor.constraint(equalTo: canvasView.bottomAnchor, constant: CGFloat(tile.yPositionOnCanvas))
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
        guard let node = sender as? CanvasNode else {
            return
        }
        guard let tile = node.visualGridElement else {
            return
        }
        tile.changeTileState(state: .modified, newColor: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))
    }

    func calculateCanvasWidth() -> CGFloat {
        return CGFloat(numberOfColumns * squareSize)

    }

    func calcutateCanvasHeight() -> CGFloat {
        return CGFloat(numberOfLines * squareSize)
    }
}
