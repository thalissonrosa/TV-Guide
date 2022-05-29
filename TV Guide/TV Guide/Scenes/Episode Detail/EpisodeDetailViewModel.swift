//
//  EpisodeDetailViewModel.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 29/05/22.
//

import Foundation

import Differentiator
import Foundation
import RxRelay
import RxSwift
import RxCocoa

enum EpisodeDetailItem {
    case picture(imageURL: URL)
    case header(episode: Episode)
    case summary(episode: Episode)
}

struct EpisodeSection {
    var header: String?
    var items: [EpisodeDetailItem]
}

extension EpisodeSection: SectionModelType {
    typealias Item = EpisodeDetailItem
    init(original: EpisodeSection, items: [Item]) {
        self = original
        self.items = items
    }
}

protocol EpisodeDetailViewModel: AnyObject {
    var items: Driver<[EpisodeSection]> { get }
    var episode: Episode { get }
}

final class EpisodeDetailViewModelImpl: EpisodeDetailViewModel {
    private let disposeBag = DisposeBag()
    private var _items: BehaviorRelay<[EpisodeSection]>
    var items: Driver<[EpisodeSection]> {
        _items.asDriver()
    }
    let episode: Episode

    init(
        episode: Episode
    ) {
        self.episode = episode
        var items: [EpisodeDetailItem] = [
//            .header(episode: episode),
            .summary(episode: episode)
        ]
        if let url = episode.image?.originalURL {
            items.insert(.picture(imageURL: url), at: 0)
        }
        _items = BehaviorRelay<[EpisodeSection]>(
            value: [
                EpisodeSection(
                    header: nil,
                    items: items
                )
            ]
        )
    }
}
