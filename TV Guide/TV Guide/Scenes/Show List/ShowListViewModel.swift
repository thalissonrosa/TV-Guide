//
//  ShowListViewModel.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 27/05/22.
//

import Foundation

protocol ShowListViewModel: AnyObject {
    var numberOfItems: Int { get }
    func show(at index: Int) -> ShowLite
}

final class ShowListViewModelImpl: ShowListViewModel {
    //TODO: Replace hardcoded data with API data
    private let shows: [ShowLite] = [
        ShowLite(
            name: "Firefly",
            posterImageURL: "https://static.tvmaze.com/uploads/images/medium_portrait/1/2600.jpg")
        ,
        ShowLite(
            name: "Community",
            posterImageURL: "https://static.tvmaze.com/uploads/images/medium_portrait/2/5134.jpg"
        ),
        ShowLite(
            name: "Band of Brothers",
            posterImageURL: "https://static.tvmaze.com/uploads/images/medium_portrait/80/201679.jpg"
        ),
        ShowLite(
            name: "The Wire",
            posterImageURL: "https://static.tvmaze.com/uploads/images/medium_portrait/1/2527.jpg"
        )
    ]
    var numberOfItems: Int {
        shows.count
    }

    func show(at index: Int) -> ShowLite {
        shows[index]
    }
}
