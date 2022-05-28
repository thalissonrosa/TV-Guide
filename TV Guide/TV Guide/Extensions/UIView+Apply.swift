//
//  UIView+Apply.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 28/05/22.
//

import UIKit

protocol ApplyProtocol {
    associatedtype ApplyType
    func apply(closure: (ApplyType) -> Void) -> ApplyType
}

extension UIView: ApplyProtocol {}
extension NSLayoutConstraint: ApplyProtocol {}

extension ApplyProtocol where Self: AnyObject {
    @discardableResult
    func apply(closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }
}
