//
//  TVMazeAPI.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 27/05/22.
//

import Foundation

struct ShowListAPI: APIHandler {
    func parseResponse(data: Data) throws -> [Show] {
        let decoder = JSONDecoder()
        return try decoder.decode([Show].self, from: data)
    }
}

struct SearchListAPI: APIHandler {
    func parseResponse(data: Data) throws -> [Show] {
        let decoder = JSONDecoder()
        let result = try decoder.decode([SearchResult].self, from: data)
        return result.map { $0.show }
    }
}
