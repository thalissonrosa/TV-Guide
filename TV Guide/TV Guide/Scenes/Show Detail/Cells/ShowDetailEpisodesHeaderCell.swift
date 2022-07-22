//
//  ShowDetailEpisodesHeaderCell.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 29/05/22.
//

import UIKit

final class ShowDetailEpisodesHeaderCell: UITableViewCell {
    // MARK: Properties
    private let episodesLabel: UILabel = {
        let label = UILabel()
        label.font = .boldTitle
        label.numberOfLines = 1
        label.text = R.string.localizable.show_detail_episodes()
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
}

// MARK: Private methods
private extension ShowDetailEpisodesHeaderCell {
    func setupUI() {
        selectionStyle = .none
        contentView.apply {
            $0.addSubview(episodesLabel)
        }
        episodesLabel.addConstraintsToFillSuperview(insets: Dimension.labelConstraintInsets)
    }
}

// MARK: Constants
private extension ShowDetailEpisodesHeaderCell {
    struct Dimension {
        static let labelConstraintInsets = UIEdgeInsets(
            top: 5.0,
            left: Constants.defaultHorizontalSpace,
            bottom: 0.0,
            right: Constants.defaultHorizontalSpace
        )
    }
}
