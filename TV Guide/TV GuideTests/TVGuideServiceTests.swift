//
//  TVGuideServiceTests.swift
//  TV GuideTests
//
//  Created by Thalisson da Rosa on 29/05/22.
//

import RxSwift
import XCTest
@testable import TV_Guide

class TVGuideServiceTests: XCTestCase {
    var tvGuideService: TVGuideService!
    var seasonsLoader: APILoader<SeasonListAPI>!
    var seasonsRequest: SeasonListAPI!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        seasonsRequest = SeasonListAPI()
        let mockNetworkSession = MockNetworkSession()
        guard let seasonsJsonData = JSONUtils.jsonDataFromFile(name: "seasons") else {
            fatalError("JSON invalid or not found")
        }
        mockNetworkSession.data = seasonsJsonData
        seasonsLoader = APILoader(apiRequest: seasonsRequest, urlSession: mockNetworkSession)
        tvGuideService = TVGuideService(seasonsLoader: seasonsLoader)
        disposeBag = DisposeBag()
    }

    func testSeasonsBuildsCorrectly() {
        var response: Seasons?
        let expectation = self.expectation(description: "Seasons retrieved correctly")

        tvGuideService.getSeasons(show: Show.emptyShow).subscribe { seasons in
            response = seasons
            expectation.fulfill()
        } onFailure: { _ in
            response = nil
        }.disposed(by: disposeBag)

        waitForExpectations(timeout: 1, handler: nil)
        guard let response = response else {
            XCTFail("Posts response should not be nil")
            return
        }
        XCTAssertTrue(response.seasons.count == 2)
        XCTAssertTrue(response.seasons[0].episodes[0].name == "Pilot")
        XCTAssertTrue(response.seasons[1].episodes[2].name == "Outbreak")
    }
}

private extension Show {
    static var emptyShow: Show {
        Show(id: 0, name: "", image: nil, summary: "", genres: [], schedule: Schedule(time: "", days: []))
    }
}
