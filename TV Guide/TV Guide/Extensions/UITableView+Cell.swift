//
//  UITableView+Cell.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 27/05/22.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type) {
        let className = cellType.className
        register(cellType, forCellReuseIdentifier: className)
    }

    func register(cellTypes: [UITableViewCell.Type]) {
        cellTypes.forEach { register(cellType: $0) }
    }

    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: type.className) as? T else {
            fatalError("Failed to acquire a cell with identifier: \(type.className)")
        }
        return cell
    }
}

private extension NSObject {
    class var className: String {
        String(describing: self)
    }
}
