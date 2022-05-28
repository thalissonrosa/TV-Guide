//
//  ShowsListViewController.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 27/05/22.
//

import RxCocoa
import RxSwift
import UIKit

final class ShowsListViewController: UIViewController {
    // MARK: Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(cellTypes: [
            ShowListTableViewCell.self,
            LoadMoreTableViewCell.self
        ])
        tableView.delegate = self
        tableView.rowHeight = Dimension.cellHeight
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    private let viewModel: ShowListViewModel
    private let disposeBag = DisposeBag()

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
        bindTableView()
        bindSearchBar()
    }
}

// MARK: Private functions
private extension ShowsListViewController {
    func setupUI() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func bindTableView() {
        viewModel.items.bind(to: tableView.rx.items) { (tableView, _, item) in
            switch item {
            case .item(let show):
                let cell = tableView.dequeueReusableCell(with: ShowListTableViewCell.self)
                cell.bind(show: show)
                return cell
            case .loadMore:
                return tableView.dequeueReusableCell(with: LoadMoreTableViewCell.self)
            }
        }.disposed(by: disposeBag)

        tableView.rx.didScroll.subscribe { [weak searchBar] _ in
            searchBar?.resignFirstResponder()
        }.disposed(by: disposeBag)

    }

    func bindSearchBar() {
        searchBar.rx.text.subscribe(onNext: { [weak self] text in
            guard let text = text, text.isEmpty else {
                return
            }
            self?.viewModel.refresh()
        }).disposed(by: disposeBag)

        searchBar.rx.searchButtonClicked.subscribe(onNext: { [weak self] in
            self?.searchBar.resignFirstResponder()
            self?.viewModel.search(query: self?.searchBar.text)
        }).disposed(by: disposeBag)
    }
}

// MARK: UITableViewDelegate methods
extension ShowsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.item == viewModel.items.value.count - 1, viewModel.haveMoreItems else { return }
        viewModel.loadMore()
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? LoadMoreTableViewCell)?.stopAnimating()
    }
}

// MARK: Constants
private extension ShowsListViewController {
    struct Dimension {
        static let cellHeight: CGFloat = 72.0
    }

    struct Constant {
        static let contentOffsetThreshold: CGFloat = 100.0
    }
}
