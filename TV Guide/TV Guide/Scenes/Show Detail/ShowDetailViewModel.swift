//
//  ShowDetailViewModel.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 28/05/22.
//

import Differentiator
import Foundation
import RxRelay

enum ShowDetailItem {
    case header(show: Show)
    case summary(show: Show)
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
    var items: [DetailSection] { get }
    var show: Show { get }
}

final class ShowDetailViewModelImpl: ShowDetailViewModel {
    var items: [DetailSection]
    let show: Show

    init(show: Show) {
        self.show = show
        items = [
            DetailSection(
                header: nil,
                items: [
                    .header(show: show),
                    .summary(show: show)
                ]
            )
        ]
    }
}
