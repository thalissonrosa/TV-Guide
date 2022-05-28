//
//  TVMazeRouter.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 27/05/22.
//

import Foundation

enum TVMazeRouter: Router {
    case getShows(page: Int)

    var scheme: String {
        "https"
    }

    var host: String {
        "api.tvmaze.com"
    }

    var path: String {
        switch self {
        case .getShows:
            return "/shows"
        }
    }

    var method: String {
        "GET"
    }

    var headers: [String : String] {
        [:]
    }

    var parameters: [URLQueryItem] {
        switch self {
        case .getShows(let page):
            return [URLQueryItem(name: "page", value: String(page))]
        }
    }
}
