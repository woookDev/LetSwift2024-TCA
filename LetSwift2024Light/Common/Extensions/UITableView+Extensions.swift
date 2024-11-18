//
//  UITableView+Extensions.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/16/24.
//

import UIKit

extension UITableView {
    // 1. UITableViewCell register & dequeue

    public func register<T: UITableViewCell>(type: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: type))
    }

    public func register(nib: UINib?, withCellClass type: (some UITableViewCell).Type) {
        register(nib, forCellReuseIdentifier: String(describing: type))
    }

    public func dequeueReusableCell<T: UITableViewCell>(withCellClass _: T.Type, indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }

    // 2. UITableViewHeaderFooterView register & dequeue

    public func register<T: UITableViewHeaderFooterView>(
        headerFooterViewClass type: T.Type
    ) {
        register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: type))
    }

    public func register(
        nib: UINib?,
        withHeaderFooterViewClass type: (some UITableViewHeaderFooterView).Type
    ) {
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: type))
    }

    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(
        withClass type: T.Type
    ) -> T {
        dequeueReusableHeaderFooterView(withIdentifier: String(describing: type)) as! T
    }
}
