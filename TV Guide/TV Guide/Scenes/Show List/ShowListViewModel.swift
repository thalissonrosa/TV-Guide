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
    func search(query: String?)
}

final class ShowListViewModelImpl: ShowListViewModel {
    private let service: TVGuideService
    private let disposeBag = DisposeBag()
    private var page = 0
    private var currentQuery = ""

    let items = BehaviorRelay<[ShowListItem]>(value: [])
    private(set) var haveMoreItems: Bool = true

    init(service: TVGuideService = TVGuideService()) {
        self.service = service
    }

    func refresh() {
        currentQuery = ""
        haveMoreItems = true
        loadShows(isRefresh: true)
    }

    func loadMore() {
        guard haveMoreItems else { return }
        loadShows(isRefresh: false)
    }

    func search(query: String?) {
        guard let query = query else {
            refresh()
            return
        }
        guard currentQuery != query else { return }
        currentQuery = query
        haveMoreItems = false
        service.search(query: query).subscribe { [weak self] shows in
            let items = self?.handleResponse(shows: shows) ?? []
            self?.handle(newItems: items, isRefresh: true)
        } onFailure: { [weak self] error in
            self?.handle(newItems: [], isRefresh: true)
        }.disposed(by: disposeBag)
    }
}

// MARK: Private methods
private extension ShowListViewModelImpl {
    func loadShows(isRefresh: Bool) {
        service.getShows(page: isRefresh ? 0 : page).subscribe { [weak self] shows in
            let items = self?.handleResponse(shows: shows) ?? []
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

    func handleResponse(shows: [ShowLite]) -> [ShowListItem] {
        var items = shows.map { ShowListItem.item(show: $0) }
        if haveMoreItems {
            items.append(.loadMore)
        }
        return items
    }
}
