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

    private let coreDataController = CanvasImageCoreDataController()
    private let motherView = UIView()
    private let canvasView = UIView()
    private var numberOfLines: Int = 0
    private var numberOfColumns: Int = 0
    private let squareSize: Int = 80
    private var grid: VisualGrid?
    private var tiles: [VisualGridElement]?
    private var gestureRecognizer: UITapGestureRecognizer! = nil
    private var longPressRecognizer: UILongPressGestureRecognizer! = nil
    private var isInColorWheel: Bool = false

    private lazy var colorWheelCenterXAnchor = self.colorWheelView.centerXAnchor.constraint(
        equalTo: self.view.centerXAnchor)
    lazy var colorWheelView = ColorWheelView(frame: UIScreen.main.bounds,
                                             viewControllerDelegate: self)
    lazy private var sideMenu = SideMenuView(frame: self.view.frame,
                                             delegate: self,
                                             type: .save)
    public weak var delegate: ReloadControllerDelegate?

    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        let nodePosition = UserDefaultAccess.nodePositin

        guard
            !nodePosition.isEmpty,
            !isInColorWheel,
            let grid = grid
            else {
                return [sideMenu.returnView]
        }

        let xPosition = nodePosition[0]
        let yPosition = nodePosition[1]

        let logicalGrid = grid.grid
        guard let index = logicalGrid.findElementIndex(by: xPosition, by: yPosition) else {
            return [sideMenu.returnView]
        }

        let tile = grid.tiles[index]
        let node = tile.node

        return [node]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        self.view.addSubview(sideMenu)
        self.setupInitalGrid()
        setNeedsFocusUpdate()
        updateFocusIfNeeded()
    }

    override func viewDidDisappear(_ animated: Bool) {
        ConnectionSocket.shared.disconnect()
    }

    // MARK: - GRID
    func setupInitalGrid() {
        self.view.showLoading(.large)
        ConnectionSocket.shared.setupDelegate(delegate: self)
        ConnectionSocket.shared.connect()
    }

    func setupGrid(_ numberOfColumns: Int, _ numberOfLines: Int, _ mapColors: MapColors) {
        self.view.removeLoading()
        self.view.addSubview(motherView)
        self.motherView.addSubview(canvasView)

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
        setupMotherViewConstraints()
        setupCanvasViewConstraints()
        setupGridConstraints()
        setupColorWheel()
        setupColorWheelContraints()
    }

    func setupMotherViewConstraints() {
        motherView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            motherView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            motherView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            motherView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            motherView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
                                                constant: SideMenuViewSizeHelper.width)
        ])
    }

    func setupCanvasViewConstraints() {
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            canvasView.centerXAnchor.constraint(equalTo: self.motherView.centerXAnchor, constant: 0),
            canvasView.centerYAnchor.constraint(equalTo: self.motherView.centerYAnchor, constant: 0),
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
            self.gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeTileColor(sender:)))
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

    // MARK: - Delegate
    func end() {
        self.navigationController?.present(setupAlertController(), animated: true, completion: nil)
    }
    func selectedColor(color: UIColor) {
        UserDefaultAccess.paitingColor = color
        grid?.selectedColor(color: color)
        dismissColorWheel()
    }

    func setupColorWheel() {
        view.addSubview(colorWheelView)
    }

    func dismissColorWheel() {

        UIView.animate(withDuration: 1.0, delay: 1.2, options: .curveEaseIn, animations: {
            NSLayoutConstraint.deactivate([self.colorWheelCenterXAnchor])
        })

        setNeedsFocusUpdate()

        self.isInColorWheel = false

    }

    // MARK: - ColorWheel

    func setupColorWheelContraints() {
        colorWheelView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            colorWheelView.heightAnchor.constraint(equalToConstant: view.frame.size.height),
            colorWheelView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            colorWheelView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: self.view.frame.width),
            colorWheelView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])

    }
    
    // MARK: - Alert Controller
    
    private func setupAlertController() -> UIAlertController{
        
        let finishedCanvasAlert = UIAlertController(title: "Canvas Finalizado", message: "Um novo Canvas sera criado, o que deseja fazer?", preferredStyle: .alert)
        
        let openNewCanvasAction = UIAlertAction(title: "Abrir novo Canvas", style: .default, handler: { _ in
            ConnectionSocket.shared.connect()
        }) 
        
        let saveCanvasImageAction = UIAlertAction(title: "Salvar e abrir novo Canvas", style: .default, handler: { _ in
            self.save()
            ConnectionSocket.shared.connect()
        }) 
        
        let goToMenuAndSaveCanvasAction = UIAlertAction(title: "Salvar e ir para o menu", style: .default, handler: { _ in
            self.save()
            self.navigationController?.popViewController(animated: true)
        }) 
        
        let goToMenuAction = UIAlertAction(title: "Ir para o menu", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        })
                
        finishedCanvasAlert.addAction(openNewCanvasAction)
        finishedCanvasAlert.addAction(saveCanvasImageAction)
        finishedCanvasAlert.addAction(goToMenuAndSaveCanvasAction)
        finishedCanvasAlert.addAction(goToMenuAction)
        
        return finishedCanvasAlert
    }
    
    
    

    // MARK: - Objc funcs

    @objc func presentColorWheel() {
        UIView.animate(withDuration: 1.0, delay: 1.2, options: .curveEaseIn, animations: {
            NSLayoutConstraint.activate([
                self.colorWheelCenterXAnchor
            ])
        })

        guard
            let grid = grid,
            let node = grid.getSelected(),
            let tile = node.visualGridElement
            else {
                return
        }

        self.isInColorWheel = true

        UserDefaultAccess.nodePositin = [tile.xPosition, tile.yPosition]
    }

    @objc func changeTileColor(sender: UITapGestureRecognizer) {

        guard
            let grid = grid,
            let node = grid.getSelected(),
            let tile = node.visualGridElement,
            tile.hasBeenModified == false
            else {
                return
        }

        UserDefaultAccess.nodePositin = [tile.xPosition, tile.yPosition]
        
        let paintColor = UserDefaultAccess.paitingColor ?? #colorLiteral(red: 0.1647058824, green: 0.4823529412, blue: 0.6078431373, alpha: 1)
        
        ConnectionSocket.shared.drawToServer(color: paintColor,
                                             (xPosition: tile.xPosition,
                                              yPosition: tile.yPosition))
    }

}

extension CanvasViewController: SideMenuViewDelegate {

    private func printImage() -> UIImage? {
        let bounds = UIScreen.main.bounds
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        self.canvasView.drawHierarchy(in: bounds, afterScreenUpdates: false)
        let savedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return savedImage
    }
    func save() {
        guard let data = self.printImage()?.pngData() else { return }
        let uniqueIdentifier = UUID().uuidString
        let canvasImage = CanvasImage(data: data, identifier: uniqueIdentifier)
        do {
            try coreDataController.create(newRecord: canvasImage)
        } catch {
            print(DAOError.internalError(description: "Failed to create NSObject"))
        }
    }

    func back() {
        self.delegate?.reload()
        self.navigationController?.popViewController(animated: true)
    }
}
