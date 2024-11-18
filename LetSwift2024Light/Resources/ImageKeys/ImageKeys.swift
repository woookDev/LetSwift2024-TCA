//
//  ImageKeys.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/16/24.
//

import UIKit

enum ImageKeys: String {
    case mainLogo = "img_main_logo"
}

extension UIImage {
    convenience init? (imageKey: ImageKeys) {
        self.init(named: imageKey.rawValue)
    }
}
