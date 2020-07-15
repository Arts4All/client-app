//
//  PlayButton.swift
//  Art4All
//
//  Created by Rayane Xavier on 14/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import UIKit

class PlayButton: UIButton {

    public override func didUpdateFocus(in context: UIFocusUpdateContext,
                                        with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)

        if context.nextFocusedView == self {
            self.layer.borderWidth = 3
            self.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)

        }
    }
}
