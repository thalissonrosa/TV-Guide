//
//  EpisodeDetailsTableCell.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 29/05/22.
//

import UIKit

final class EpisodeDetailsTableCell: UITableViewCell {
    // MARK: Properties
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Dimension.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let episodeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldTitle
        label.numberOfLines = 0
        return label
    }()
    private let episodeSeasonNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .mediumRegular
        label.numberOfLines = 0
        return label
    }()

    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public methods
    func bind(episode: Episode) {
        episodeNameLabel.text = episode.name
        episodeSeasonNumberLabel.text = R.string.localizable.episode_detail_season_episode(
            episode.season,
            episode.number
        )
    }
}

// MARK: Private methods
private extension EpisodeDetailsTableCell {
    func setupUI() {
        selectionStyle = .none
        contentView.apply {
            $0.addSubview(verticalStackView.apply {
                $0.addArrangedSubview(episodeNameLabel)
                $0.addArrangedSubview(episodeSeasonNumberLabel)
            })
        }
        verticalStackView.addConstraintsToFillSuperview(insets: Dimension.stackViewInsets)
    }
}

// MARK: Constants
private extension EpisodeDetailsTableCell {
    struct Dimension {
        static let stackViewSpacing: CGFloat = 6.0
        static let stackViewInsets = UIEdgeInsets(
            top: 5.0,
            left: Constants.defaultHorizontalSpace,
            bottom: 10.0,
            right: Constants.defaultHorizontalSpace
        )
    }
}
