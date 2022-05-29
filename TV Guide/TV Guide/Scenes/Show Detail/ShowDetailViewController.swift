//
//  ShowDetailViewController.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 28/05/22.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

final class ShowDetailViewController: UIViewController {
    // MARK: Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(cellTypes: [
            ShowDetailHeaderTableCell.self,
            ShowDetailSummaryTableCell.self,
            ShowDetailEpisodeTableCell.self,
            ShowDetailEpisodesHeaderCell.self,
        ])
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private let dataSource = RxTableViewSectionedReloadDataSource<DetailSection>(
        configureCell: { dataSource, tableView, indexPath, item in
            switch item {
            case .header(let show):
                let cell = tableView.dequeueReusableCell(with: ShowDetailHeaderTableCell.self)
                cell.bind(show: show)
                return cell
            case .summary(let show):
                let cell = tableView.dequeueReusableCell(with: ShowDetailSummaryTableCell.self)
                cell.bind(show: show)
                return cell
            case .episode(let episode):
                let cell = tableView.dequeueReusableCell(with: ShowDetailEpisodeTableCell.self)
                cell.bind(episode: episode)
                return cell
            case .episodeHeader:
                return tableView.dequeueReusableCell(with: ShowDetailEpisodesHeaderCell.self)
            }
        }
    )
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
        viewModel.loadSeasons()
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
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].header
        }
        viewModel.items
            .asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(ShowDetailItem.self).subscribe(onNext: { item in
            switch item {
            case .episode(let episode):
                print(episode.name)
            default:
                return
            }
        }).disposed(by: disposeBag)

        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
        }).disposed(by: disposeBag)
    }
}
