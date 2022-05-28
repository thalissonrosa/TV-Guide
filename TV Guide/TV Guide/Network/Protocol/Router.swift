//
//  Router.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 27/05/22.
//

import Foundation

protocol Router {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: String { get }
    var headers: [String: String] { get }
    var parameters: [URLQueryItem] { get }
}
