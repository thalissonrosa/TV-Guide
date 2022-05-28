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

    init(showListLoader: APILoader<ShowListAPI> = APILoader(apiRequest: ShowListAPI())) {
        self.showListLoader = showListLoader
    }

    func getShows(page: Int) -> Single<[ShowLite]> {
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
}
