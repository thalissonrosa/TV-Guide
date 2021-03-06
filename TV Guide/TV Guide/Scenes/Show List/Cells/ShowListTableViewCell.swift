//
//  ShowListTableViewCell.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 27/05/22.
//

import Kingfisher
import UIKit

final class ShowListTableViewCell: UITableViewCell {
    // MARK: Properties
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.defaultHorizontalSpace
        stackView.alignment = .center
        return stackView
    }()
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.kf.indicatorType = .activity
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let showNameLabel: UILabel = {
        let label = UILabel()
        label.font = .mediumRegular
        label.translatesAutoresizingMaskIntoConstraints = false
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

    // MARK: Overriden methods
    override func prepareForReuse() {
        posterImageView.kf.cancelDownloadTask()
    }

    // MARK: Public methods
    func bind(show: Show) {
        showNameLabel.text = show.name
        guard let url = show.image?.mediumURL else { return }
        posterImageView.kf.setImage(with: url, options: [.transition(.fade(Constants.imageFadeIn))])
    }
}

// MARK: Private methods
private extension ShowListTableViewCell {
    func setupUI() {
        selectedBackgroundView = UIView().apply {
            $0.backgroundColor = .highlightedColor
        }
        contentView.apply {
            $0.addSubview(containerStackView.apply {
                $0.addArrangedSubview(posterImageView)
                $0.addArrangedSubview(showNameLabel)
            })
        }
        setupConstraints()
    }

    func setupConstraints() {
        containerStackView.addConstraintsToFillSuperview(insets: Dimension.stackViewInsets)
        NSLayoutConstraint.activate([
            posterImageView.widthAnchor.constraint(
                equalTo: posterImageView.heightAnchor,
                multiplier: Dimension.posterImageRatio
            )
        ])
    }
}

// MARK: Constants
private extension ShowListTableViewCell {
    struct Dimension {
        static let stackViewInsets = UIEdgeInsets(
            top: 4.0,
            left: 16.0,
            bottom: 4.0,
            right: 16.0
        )
        static let posterImageRatio: CGFloat = 210/295
    }
}
