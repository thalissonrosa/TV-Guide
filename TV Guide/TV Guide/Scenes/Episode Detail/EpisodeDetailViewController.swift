//
//  EpisodeDetailViewController.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 29/05/22.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

final class EpisodeDetailViewController: UIViewController {
    // MARK: Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(cellTypes: [
            PictureTableCell.self,
            SummaryTableCell.self
        ])
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private let dataSource = RxTableViewSectionedReloadDataSource<EpisodeSection>(
        configureCell: { dataSource, tableView, indexPath, item in
            switch item {
            case .summary(let episode):
                let cell = tableView.dequeueReusableCell(with: SummaryTableCell.self)
                cell.bind(summary: episode.summary)
                return cell
            case .picture(let url):
                let cell = tableView.dequeueReusableCell(with: PictureTableCell.self)
                cell.bind(imageURL: url)
                return cell
            default:
                return UITableViewCell()
            }
        }
    )
    private let viewModel: EpisodeDetailViewModel
    private let disposeBag = DisposeBag()

    // MARK: Init
    init(
        viewModel: EpisodeDetailViewModel
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
        title = viewModel.episode.name
        bindTableView()
    }
}

// MARK: Private methods
private extension EpisodeDetailViewController {
    func setupUI() {
        view.apply {
            $0.addSubview(tableView)
        }
        tableView.addConstraintsToFillSuperview()
    }
    func bindTableView() {
        viewModel.items
            .asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

    }
}
