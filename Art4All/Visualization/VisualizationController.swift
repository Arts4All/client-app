//
//  VisualizationController.swift
//  Art4All
//
//  Created by Matheus Silva on 21/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import UIKit

class VisualizationController: UIViewController, SideMenuViewDelegate {
    private let coreDataController = CanvasImageCoreDataController()
    private let motherView = UIImageView()
    private var image: UIImage?
    private var identifier: String = ""
    weak var delegate: ReloadControllerDelegate?
    private var sideMenu = SideMenuView()
    private var type: ButtonType = .delete

    func setup(image: UIImage, identifier: String, delegate: ReloadControllerDelegate) {

        self.identifier = identifier
        if self.identifier == "" { type = .save }
        sideMenu = SideMenuView(frame: self.view.frame, delegate: self, type: type)
        self.view.addSubview(sideMenu)
        self.image = image
        self.motherView.image = image
        self.delegate = delegate

        self.view.backgroundColor = .backgroundColor
    }
    
    //MARK: - Override methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(motherView)
    }
    override func viewDidLayoutSubviews() {
        self.setupMotherViewConstraints()
    }
    
    //MARK: - Delegate methods
    
    func delete() {
        self.present(setupDeleteAlert(), animated: true)
    }
    
    func back() {
        self.delegate?.reload()
        self.navigationController?.popViewController(animated: true)
    }
    func save() {
        guard let data = self.image?.pngData() else { return }
        let uniqueIdentifier = UUID().uuidString
        let canvasImage = CanvasImage(data: data, identifier: uniqueIdentifier)
        do {
            try coreDataController.create(newRecord: canvasImage)
        } catch {
            print(DAOError.internalError(description: "Failed to create NSObject"))
        }
    }
    
    //MARK: - Contraints
    
    private func setupMotherViewConstraints() {
        motherView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            motherView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            motherView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            motherView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            motherView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
                                                constant: SideMenuViewSizeHelper.width)
        ])
    }
    
    //MARK: - UIAlert
    
    private func setupDeleteAlert() -> UIAlertController{
        
        let deleteAlert = UIAlertController(title: "Excluir", message: "Você realmente deseja deletar a imagem?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        let deleteAction = UIAlertAction(title: "Deletar", style: .destructive, handler: { 
            _ in
            guard let data = self.image?.pngData() else { return }
            let canvasImage = CanvasImage(data: data, identifier: self.identifier)
            do {
                try self.coreDataController.delete(deletedRecord: canvasImage)
                self.back()
            } catch {
                print(DAOError.internalError(description: error.localizedDescription))
            }
        }) 
        
        deleteAlert.addAction(cancelAction)
        deleteAlert.addAction(deleteAction)
        
        return deleteAlert
    }
}

