//
//  UIImageView+.swift
//  GariHub Driver
//
//  Created by Chrispus Onyono on 04/01/2021.
//  Copyright © 2021 Garihub Developers. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView {

    func makeRounded() {
        self.layer.borderWidth = 2
        self.contentMode = .scaleAspectFill
        self.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
    }
}
