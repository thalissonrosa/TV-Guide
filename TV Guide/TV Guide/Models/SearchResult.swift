//
//  SearchResult.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 28/05/22.
//

import Foundation

struct SearchResult: Decodable {
    let score: Double
    let show: ShowLite
}
