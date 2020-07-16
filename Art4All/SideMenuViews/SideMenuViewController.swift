//
//  CenterMenuViewController.swift
//  Art4All
//
//  Created by Rayane Xavier on 16/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    private var returnView: SideMenuView!
    private var saveView: SideMenuView!
    private var transformView: SideMenuView!
    private var tapGestureRecognizer: UITapGestureRecognizer!
    private let heightScreen = UIScreen.main.bounds.size.height
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return [saveView]
    }

    override func viewDidLoad() {
        self.setUp()
        self.view.addSubview(returnView)
        self.view.addSubview(saveView)
        self.view.addSubview(transformView)
        setNeedsFocusUpdate()
        updateFocusIfNeeded()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        self.setUpViews()
        self.returnView.setupViews()
        self.saveView.setupViews()
        self.transformView.setupViews()
    }

    func setUp() {
        setUpDescription()
    }

    @objc func tapped(sender: UITapGestureRecognizer) {
        print("funfo")
    }

    private func setUpViews() {
        self.setupCunstraintsView(view: returnView, constant: -(heightScreen * 0.125))
        self.setupCunstraintsView(view: saveView, constant: heightScreen * 0.125)
        self.setupCunstraintsView(view: transformView, constant: heightScreen * 0.375)
    }

    private func setUpDescription() {
        self.returnView = self.setupView(view: returnView, image: #imageLiteral(resourceName: "return"), text: "Voltar")
        self.saveView = self.setupView(view: saveView, image: #imageLiteral(resourceName: "save"), text: "Salvar imagem")
        self.transformView = self.setupView(view: transformView, image: #imageLiteral(resourceName: "transform"), text: "Transformar em Wallpaper")
    }

    private func setupView(view: SideMenuView?, image: UIImage, text: String) -> SideMenuView? {
        var view = view
        view = SideMenuView(frame: self.view.frame, image: image, text: text)
        view?.translatesAutoresizingMaskIntoConstraints = false
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(sender:)))
        view?.addGestureRecognizer(tapGestureRecognizer)
        return view
    }

    private func setupCunstraintsView(view: SideMenuView, constant: CGFloat) {
        let constraints = [
            view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: constant),
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.widthAnchor.constraint(equalToConstant: 300),
            view.heightAnchor.constraint(equalToConstant: heightScreen/4)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
