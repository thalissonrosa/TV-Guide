//
//  ShowDetailViewController.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 28/05/22.
//

import RxCocoa
import RxSwift
import UIKit

final class ShowDetailViewController: UIViewController {
    // MARK: Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(cellTypes: [
            ShowDetailHeaderTableCell.self
        ])
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200.0
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private let viewModel: ShowDetailViewModel
    private let disposeBag = DisposeBag()

    // MARK: Init
    init(
        viewModel: ShowDetailViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Overriden methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.show.name
        bindTableView()
    }
}

// MARK: Private methods
private extension ShowDetailViewController {
    func setupUI() {
        view.apply {
            $0.addSubview(tableView)
        }
        tableView.addConstraintsToFillSuperview()
    }
    func bindTableView() {
        viewModel.items.bind(to: tableView.rx.items) { [viewModel] (tableView, _, item) in
            switch item {
            case .header:
                let cell = tableView.dequeueReusableCell(with: ShowDetailHeaderTableCell.self)
                cell.bind(show: viewModel.show)
                return cell
            }
        }.disposed(by: disposeBag)
    }
}
