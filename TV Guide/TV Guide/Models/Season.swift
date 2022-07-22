//
//  Season.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 28/05/22.
//

import Foundation

struct Seasons: Decodable {
    let seasons: [Season]

    init(episodes: [Episode]) {
        seasons = episodes.grouped { $0.season }
            .map({ episodes in
                return Season(episodes: episodes)
            })
    }
}

struct Season: Decodable {
    let episodes: [Episode]
}

private extension Sequence {
    func grouped<T: Equatable>(by block: (Element) throws -> T) rethrows -> [[Element]] {
        return try reduce(into: []) { result, element in
            if let lastElement = result.last?.last, try block(lastElement) == block(element) {
                result[result.index(before: result.endIndex)].append(element)
            } else {
                result.append([element])
            }
        }
    }
}
