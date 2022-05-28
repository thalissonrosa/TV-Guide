//
//  TVGuideService.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 27/05/22.
//

import Foundation
import RxSwift

final class TVGuideService {
    // MARK: Properties
    private let showListLoader: APILoader<ShowListAPI>
    private let searchLoader: APILoader<SearchListAPI>

    init(
        showListLoader: APILoader<ShowListAPI> = APILoader(apiRequest: ShowListAPI()),
        searchLoard: APILoader<SearchListAPI> = APILoader(apiRequest: SearchListAPI())
    ) {
        self.showListLoader = showListLoader
        self.searchLoader = searchLoard
    }

    func getShows(page: Int) -> Single<[Show]> {
        Single.create { [weak self] single in
            self?.showListLoader.request(router: TVMazeRouter.getShows(page: page)) { result in
                switch result {
                case .success(let shows):
                    single(.success(shows))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }

    func search(query: String) -> Single<[Show]> {
        Single.create { [weak self] single in
            self?.searchLoader.request(router: TVMazeRouter.search(query: query)) { result in
                switch result {
                case .success(let shows):
                    single(.success(shows))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
