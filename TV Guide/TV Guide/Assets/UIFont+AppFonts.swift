//
//  UIFont+AppFonts.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 29/05/22.
//

import UIKit

extension UIFont {
    static func boldTitle() -> UIFont {
        .systemFont(ofSize: 24.0, weight: .bold)
    }

    static func smallRegular() -> UIFont {
        .systemFont(ofSize: 14.0, weight: .regular)
    }

    static func mediumRegular() -> UIFont {
        .systemFont(ofSize: 16.0, weight: .regular)
    }
}
