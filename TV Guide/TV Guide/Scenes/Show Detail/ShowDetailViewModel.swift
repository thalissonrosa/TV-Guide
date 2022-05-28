//
//  ShowDetailViewModel.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 28/05/22.
//

import Foundation
import RxRelay

enum ShowDetailItem {
    case header
}

protocol ShowDetailViewModel: AnyObject {
    var items: BehaviorRelay<[ShowDetailItem]> { get }
    var show: ShowLite { get }
}

final class ShowDetailViewModelImpl: ShowDetailViewModel {
    let items = BehaviorRelay<[ShowDetailItem]>(value: [.header])
    let show: ShowLite

    init(show: ShowLite) {
        self.show = show
    }
}
