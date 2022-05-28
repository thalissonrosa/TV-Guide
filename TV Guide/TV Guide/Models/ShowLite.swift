//
//  ShowLite.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 27/05/22.
//

import Foundation

struct ShowLite: Decodable {
    let name: String
    let image: Images
}

struct Images: Decodable {
    let medium: String
    let original: String
}
