//
//  CenterMenuViewController.swift
//  Art4All
//
//  Created by Rayane Xavier on 16/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//
import UIKit

enum ButtonType {
    case save, delete
}

class SideMenuView: UIView {
    private var type: ButtonType = .save
    private var returnView: SideMenu!
    private var typeView: SideMenu!
    private var deleteView: SideMenu!
    private var tapGestureRecognizer: UITapGestureRecognizer!
    private let heightScreen = UIScreen.main.bounds.size.height
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return [returnView]
    }
    private var choiceType: (image: UIImage, text: String) {
        var image = UIImage()
        var text = ""
        switch type {
        case .save:
            image = #imageLiteral(resourceName: "save")
            text = "Salvar imagem"
        case .delete:
            image = #imageLiteral(resourceName: "delete")
            text = "Excluir das imagens salvas"
        }
        return (image: image, text: text)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect, delegate: SideMenuViewDelegate, type: ButtonType) {
        self.init(frame: frame)
        self.delegate = delegate
        self.type = type
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    weak var delegate: SideMenuViewDelegate?
    override func layoutSubviews() {
        self.setup()
        self.addSubview(returnView)
        self.addSubview(typeView)
        setNeedsFocusUpdate()
        updateFocusIfNeeded()
        viewWillLayoutSubviews()
    }

    func viewWillLayoutSubviews() {
        self.setupViews()
    }

    func setup() {
        setupDescription()
    }

    @objc func tapped(sender: UITapGestureRecognizer) {
        if returnView.isFocused {
            delegate?.back()
        } else if typeView.isFocused {
            switch type {
            case .save:
                delegate?.save?()
            case .delete:
                delegate?.delete?()
            }
        }
    }

    private func setupViews() {
        self.setupCunstraintsView(view: returnView, constant: -(SideMenuViewSizeHelper.height))
        self.setupCunstraintsView(view: typeView, constant: SideMenuViewSizeHelper.height)
    }

    private func setupDescription() {
        self.returnView = self.setupView(view: returnView, image: #imageLiteral(resourceName: "return"), text: "Voltar")
        self.typeView = self.setupView(view: typeView, image: choiceType.image, text: choiceType.text)
        self.typeView.type = type
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
            view.widthAnchor.constraint(equalToConstant: SideMenuViewSizeHelper.width),
            view.heightAnchor.constraint(equalToConstant: heightScreen/4)
        ]
        NSLayoutConstraint.activate(constraints)
        view.setupViews()
    }
}
