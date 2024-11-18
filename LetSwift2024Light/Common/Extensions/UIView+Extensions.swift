//
//  UIView+Extensions.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/16/24.
//

import UIKit

extension UIView {
    public func addSubviews(_ views: [UIView]) {
        views.forEach(addSubview)
    }

    public func addSubviews(_ views: UIView...) {
        addSubviews(views)
    }

    public func withSubviews(_ views: [UIView]) -> Self {
        addSubviews(views)
        return self
    }

    public func withSubviews(_ views: UIView...) -> Self {
        withSubviews(views)
    }
}
