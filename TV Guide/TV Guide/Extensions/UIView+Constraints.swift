//
//  UIView+Constraints.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 27/05/22.
//

import UIKit

extension UIView {
    func addConstraintsToFillSuperview(insets: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            fatalError("\(String(describing: self)) has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(
                equalTo: superview.leadingAnchor,
                constant: insets.left
            ),
            topAnchor.constraint(
                equalTo: superview.safeAreaLayoutGuide.topAnchor,
                constant: insets.top
            ),
            trailingAnchor.constraint(
                equalTo: superview.trailingAnchor,
                constant: -insets.right
            ),
            bottomAnchor.constraint(
                equalTo: superview.safeAreaLayoutGuide.bottomAnchor,
                constant: -insets.bottom
            )
        ])
    }
}
