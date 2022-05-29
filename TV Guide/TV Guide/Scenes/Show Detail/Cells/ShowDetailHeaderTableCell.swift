//
//  ShowDetailHeaderTableCell.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 28/05/22.
//

import Kingfisher
import UIKit

final class ShowDetailHeaderTableCell: UITableViewCell {
    // MARK: Properties
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let showNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldTitle
        label.numberOfLines = 2
        return label
    }()
    private let genresLabel: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        label.numberOfLines = 0
        return label
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .mediumRegular
        label.numberOfLines = 1
        return label
    }()
    private let daysLabel: UILabel = {
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

    // MARK: Overriden methods
    override func prepareForReuse() {
        posterImageView.kf.cancelDownloadTask()
    }

    // MARK: Public methods
    func bind(show: Show) {
        showNameLabel.text = show.name
        let separator = R.string.localizable.common_separator()
        let notApplicable = R.string.localizable.common_not_aplicable()
        genresLabel.text = show.genres?.joined(separator: separator)
        timeLabel.text = R.string.localizable.show_detail_time(show.schedule.time ?? notApplicable)
        daysLabel.text = R.string.localizable.show_detail_days(
            show.schedule.days?.joined(separator: separator) ?? notApplicable
        )
        guard let url = show.image?.originalURL else { return }
        posterImageView.kf.setImage(with: url, options: [.transition(.fade(Constant.imageFadeIn))])
    }
}

// MARK: Private methods
private extension ShowDetailHeaderTableCell {
    func setupUI() {
        selectionStyle = .none
        contentView.apply {
            $0.addSubview(posterImageView)
            $0.addSubview(verticalStackView.apply {
                $0.addArrangedSubview(showNameLabel)
                $0.addArrangedSubview(genresLabel)
                $0.addArrangedSubview(timeLabel)
                $0.addArrangedSubview(daysLabel)
            })
        }
        setupConstraints()
        verticalStackView.setCustomSpacing(Dimension.descriptionVerticalSpacing, after: genresLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Dimension.horizontalSpacing
            ),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            posterImageView.widthAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: Dimension.posterWidthMultiplier
            ),
            posterImageView.heightAnchor.constraint(
                equalTo: posterImageView.widthAnchor,
                multiplier: Dimension.posterHeightImageRatio
            ).apply {
                $0.priority = .defaultHigh
            },

            verticalStackView.leadingAnchor.constraint(
                equalTo: posterImageView.trailingAnchor,
                constant: Dimension.horizontalSpacing
            ),
            verticalStackView.topAnchor.constraint(
                equalTo: posterImageView.topAnchor,
                constant: Dimension.stackViewTopMargin
            ),
            verticalStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Dimension.horizontalSpacing
            )
        ])
    }
}

// MARK: Constants
private extension ShowDetailHeaderTableCell {
    struct Dimension {
        static let stackViewTopMargin: CGFloat = 12.0
        static let horizontalSpacing: CGFloat = 10.0
        static let posterHeightImageRatio: CGFloat = 1000/680
        static let posterWidthMultiplier: CGFloat = 1/3
        static let descriptionVerticalSpacing: CGFloat = 10.0
    }

    struct Constant {
        static let imageFadeIn: TimeInterval = 0.3
    }
}
