//
//  MockNetworkSession.swift
//  TV GuideTests
//
//  Created by Thalisson da Rosa on 29/05/22.
//

import Foundation
@testable import TV_Guide

class MockNetworkSession: NetworkSession {
    var data: Data?
    var error: Error?
    var response: URLResponse?

    func loadData(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completionHandler(data, response, error)
    }
}
