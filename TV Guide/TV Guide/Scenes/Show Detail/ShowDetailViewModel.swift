//
//  ShowDetailViewModel.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 28/05/22.
//

import Differentiator
import Foundation
import RxRelay
import RxSwift
import RxCocoa

enum ShowDetailItem {
    case header(show: Show)
    case summary(show: Show)
    case episode(_ episode: Episode)
    case episodeHeader
}

struct DetailSection {
    var header: String?
    var items: [ShowDetailItem]
}

extension DetailSection: SectionModelType {
    typealias Item = ShowDetailItem
    init(original: DetailSection, items: [Item]) {
        self = original
        self.items = items
    }
}

protocol ShowDetailViewModel: AnyObject {
    var items: Driver<[DetailSection]> { get }
    var show: Show { get }
    func loadSeasons()
}

final class ShowDetailViewModelImpl: ShowDetailViewModel {
    private let service: TVGuideService
    private let disposeBag = DisposeBag()
    private var _items: BehaviorRelay<[DetailSection]>
    var items: Driver<[DetailSection]> {
        _items.asDriver()
    }
    let show: Show

    init(
        show: Show,
        service: TVGuideService = TVGuideService()
    ) {
        self.show = show
        self.service = service
        _items = BehaviorRelay<[DetailSection]>(
            value: [
                DetailSection(
                    header: nil,
                    items: [
                        .header(show: show),
                        .summary(show: show),
                        .episodeHeader
                    ]
                )
            ]
        )
    }

    func loadSeasons() {
        service.getSeasons(show: show).subscribe(onSuccess: { seasons in
            let sections = seasons.seasons.map { season -> DetailSection in
                var header: String? = nil
                if let seasonNumber = season.episodes.first?.season {
                    header = R.string.localizable.show_detail_season_header(seasonNumber)
                }
                return DetailSection(header: header, items: season.episodes.map { ShowDetailItem.episode($0) })
            }
            self._items.accept(self._items.value + sections)
        }).disposed(by: disposeBag)
    }
}
