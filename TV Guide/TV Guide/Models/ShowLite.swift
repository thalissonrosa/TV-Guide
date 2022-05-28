//
//  ShowLite.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 27/05/22.
//

import Foundation

struct ShowLite: Decodable {
    let name: String
    let image: Images?
    let summary: String
    let genres: [String]?
    let schedule: Schedule
}

struct Images: Decodable {
    let mediumURL: URL?
    let originalURL: URL?

    enum CodingKeys: String, CodingKey {
        case mediumURL = "medium"
        case originalURL = "original"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mediumURL = URL(string: try container.decode(String.self, forKey: .mediumURL))
        self.originalURL = URL(string: try container.decode(String.self, forKey: .originalURL))
    }
}

struct Schedule: Decodable {
    let time: String?
    let days: [String]?
}
