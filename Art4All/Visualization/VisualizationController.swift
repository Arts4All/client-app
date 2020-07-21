//
//  VisualizationController.swift
//  Art4All
//
//  Created by Matheus Silva on 21/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import UIKit

class VisualizationController: UIViewController {
    private let motherView = UIImageView()
    private var image: UIImage?
    private weak var delegate: ReloadControllerDelegate?
    private lazy var sideMenu = SideMenuView(frame: self.view.frame,
                                             delegate: self,
                                             type: .delete)

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view.addSubview(sideMenu)
    }
    convenience init(nibName nibNameOrNil: String?,
                     bundle nibBundleOrNil: Bundle?,
                     image: UIImage,
                     delegate: ReloadControllerDelegate) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.image = image
        self.delegate = delegate
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        motherView.image = #imageLiteral(resourceName: "aslam")
        self.view.addSubview(motherView)
    }
    override func viewDidLayoutSubviews() {
        self.setupMotherViewConstraints()
    }
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
}

extension VisualizationController: SideMenuViewDelegate {
    func delete() {
        print("here")
    }

    func back() {
        self.delegate?.reload()
        self.navigationController?.popViewController(animated: true)
    }
}
