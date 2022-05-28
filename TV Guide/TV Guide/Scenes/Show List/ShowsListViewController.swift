//
//  ShowsListViewController.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 27/05/22.
//

import UIKit

final class ShowsListViewController: UIViewController {
    // MARK: Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.register(cellType: ShowListTableViewCell.self)
        tableView.rowHeight = Dimension.cellHeight
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private let viewModel: ShowListViewModel

    // MARK: Init
    init(viewModel: ShowListViewModel = ShowListViewModelImpl()) {
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
        title = R.string.localizable.show_list_title()
    }
}

// MARK: Private functions
private extension ShowsListViewController {
    func setupUI() {
        view.addSubview(tableView)
        tableView.addConstraintsToFillSuperview()
    }
}

// MARK: UITableViewDataSource methods
extension ShowsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: ShowListTableViewCell.self, for: indexPath)
        cell.bind(show: viewModel.show(at: indexPath.item))
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
}

// MARK: Constants
private extension ShowsListViewController {
    struct Dimension {
        static let cellHeight: CGFloat = 72.0
    }
}
