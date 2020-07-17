//
//  CenterMenuViewController.swift
//  Art4All
//
//  Created by Rayane Xavier on 16/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//
import UIKit

protocol SideMenuViewDelegate: class {
    func back()
    func save()
    func transform()
}

class SideMenuView: UIView {
    private var returnView: SideMenu!
    private var saveView: SideMenu!
    private var transformView: SideMenu!
    private var tapGestureRecognizer: UITapGestureRecognizer!
    private let heightScreen = UIScreen.main.bounds.size.height
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return [returnView]
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect, delegate: SideMenuViewDelegate) {
        self.init(frame: frame)
        self.delegate = delegate
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    weak var delegate: SideMenuViewDelegate?
    override func layoutSubviews() {
        self.setUp()
        self.addSubview(returnView)
        self.addSubview(saveView)
        self.addSubview(transformView)
        setNeedsFocusUpdate()
        updateFocusIfNeeded()
        viewWillLayoutSubviews()
    }

    func viewWillLayoutSubviews() {
        self.setUpViews()
        self.returnView.setupViews()
        self.saveView.setupViews()
        self.transformView.setupViews()
    }

    func setUp() {
        setUpDescription()
    }

    @objc func tapped(sender: UITapGestureRecognizer) {
        if returnView.isFocused {
            delegate?.back()
        } else if saveView.isFocused {
            delegate?.save()
        } else if transformView.isFocused {
            delegate?.transform()
        }
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

    private func setupView(view: SideMenu?, image: UIImage, text: String) -> SideMenu? {
        var view = view
        view = SideMenu(frame: self.frame, image: image, text: text)
        view?.translatesAutoresizingMaskIntoConstraints = false
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(sender:)))
        view?.addGestureRecognizer(tapGestureRecognizer)
        return view
    }

    private func setupCunstraintsView(view: SideMenu, constant: CGFloat) {
        let constraints = [
            view.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: constant),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.widthAnchor.constraint(equalToConstant: 300),
            view.heightAnchor.constraint(equalToConstant: heightScreen/4)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
