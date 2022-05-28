//
//  ShowListViewModel.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 27/05/22.
//

import Foundation
import RxSwift
import RxRelay

enum ShowListItem {
    case item(show: ShowLite)
    case loadMore
}

protocol ShowListViewModel: AnyObject {
    var items: BehaviorRelay<[ShowListItem]> { get }
    var haveMoreItems: Bool { get }
    func refresh()
    func loadMore()
}

final class ShowListViewModelImpl: ShowListViewModel {
    private let service: TVGuideService
    private let disposeBag = DisposeBag()
    private var page = 0

    let items = BehaviorRelay<[ShowListItem]>(value: [])
    private(set) var haveMoreItems: Bool = true

    init(service: TVGuideService = TVGuideService()) {
        self.service = service
    }

    func refresh() {
        loadShows(isRefresh: true)
    }

    func loadMore() {
        guard haveMoreItems else { return }
        loadShows(isRefresh: false)
    }
}

// MARK: Private methods
private extension ShowListViewModelImpl {
    func loadShows(isRefresh: Bool) {
        service.getShows(page: isRefresh ? 0 : page).subscribe { [weak self] shows in
            var items = shows.map { ShowListItem.item(show: $0) }
            items.append(.loadMore)
            self?.handle(newItems: items, isRefresh: isRefresh)
        } onFailure: { [weak self] _ in
            self?.haveMoreItems = false
            self?.handle(newItems: [], isRefresh: isRefresh)
        }.disposed(by: disposeBag)
    }

    func handle(newItems: [ShowListItem], isRefresh: Bool) {
        var currentItems = items.value
        if isRefresh {
            items.accept(newItems)
        } else {
            currentItems = currentItems.dropLast()
            items.accept(currentItems + newItems)
        }
        page += 1
    }
}
