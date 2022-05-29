//
//  Episode.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 28/05/22.
//

import Foundation

struct Episode: Decodable {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let summary: String
    let image: Images?
}
