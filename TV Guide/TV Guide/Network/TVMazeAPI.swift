//
//  TVMazeAPI.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 27/05/22.
//

import Foundation

struct ShowListAPI: APIHandler {
    func parseResponse(data: Data) throws -> [ShowLite] {
        let decoder = JSONDecoder()
        return try decoder.decode([ShowLite].self, from: data)
    }
}
