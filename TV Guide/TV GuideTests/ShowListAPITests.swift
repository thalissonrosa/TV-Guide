//
//  TV_GuideTests.swift
//  TV GuideTests
//
//  Created by Thalisson da Rosa on 27/05/22.
//

import XCTest
@testable import TV_Guide

class ShowListAPITests: XCTestCase {
    var showsListLoader: APILoader<ShowListAPI>!
    var request: ShowListAPI!

    override func setUpWithError() throws {
        request = ShowListAPI()
        let mockSession = MockNetworkSession()
        guard let jsonData = JSONUtils.jsonDataFromFile(name: "show_list") else {
            fatalError("JSON invalid or not found")
        }
        mockSession.data = jsonData
        showsListLoader = APILoader(apiRequest: request, urlSession: mockSession)
    }

    func testRequestBuildCorrectly() {
        do {
            let urlRequest = try request.makeRequest(from: TVMazeRouter.getShows(page: 0))
            XCTAssertTrue(urlRequest.url?.scheme == "https")
            XCTAssertTrue(urlRequest.url?.host == "api.tvmaze.com")
            XCTAssertTrue(urlRequest.url?.path == "/shows")
        } catch {
            XCTFail("Error creating request")
        }
    }

    func testResponseParsedCorrectly() {
        var response: [Show]?
        let expectation = self.expectation(description: "Response parsed correctly")

        showsListLoader.request(router: TVMazeRouter.getShows(page: 0)) { result in
            switch result {
            case let .success(shows):
                response = shows
            case .failure:
                response = nil
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        guard let response = response else {
            XCTFail("Response is nil")
            return
        }
        XCTAssertTrue(response.count == 3)
        let firstShow = response.first!
        XCTAssertTrue(firstShow.id == 1)
        XCTAssertTrue(firstShow.name == "Under the Dome")
        XCTAssertTrue(firstShow.genres?.count == 3)
    }
}
