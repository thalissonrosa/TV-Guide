//
//  EpisodeListTableCell.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 29/05/22.
//

import Kingfisher
import UIKit

final class ShowDetailEpisodeTableCell: UITableViewCell {
    // MARK: Properties
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let episodeLabel: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let backgroundColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        updateBackgroundColor(highlighted: highlighted)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        updateBackgroundColor(highlighted: selected)
    }

    // MARK: Public methods
    func bind(episode: Episode) {
        episodeLabel.text = R.string.localizable.show_detail_episode_format(
            episode.number,
            episode.name
        )
        guard let url = episode.image?.mediumURL else { return }
        posterImageView.kf.setImage(with: url, options: [.transition(.fade(Constants.imageFadeIn))])
    }
}

// MARK: Private methods
private extension ShowDetailEpisodeTableCell {
    func setupUI() {
        selectionStyle = .none
        contentView.apply {
            $0.addSubview(backgroundColorView.apply {
                $0.addSubview(posterImageView)
                $0.addSubview(episodeLabel)
            })
        }
        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundColorView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.defaultHorizontalSpace
            ),
            backgroundColorView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Dimension.verticalSpace
            ),
            backgroundColorView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.defaultHorizontalSpace
            ),
            backgroundColorView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Constants.defaultHorizontalSpace
            ),

            posterImageView.leadingAnchor.constraint(equalTo: backgroundColorView.leadingAnchor),
            posterImageView.topAnchor.constraint(equalTo: backgroundColorView.topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: backgroundColorView.bottomAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: Dimension.posterImageSize.height).apply {
                $0.priority = .defaultHigh
            },
            posterImageView.widthAnchor.constraint(equalToConstant: Dimension.posterImageSize.width),
            posterImageView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Constants.defaultHorizontalSpace
            ),

            episodeLabel.leadingAnchor.constraint(
                equalTo: posterImageView.trailingAnchor,
                constant: Constants.defaultHorizontalSpace
            ),
            episodeLabel.topAnchor.constraint(
                equalTo: posterImageView.topAnchor,
                constant: Dimension.verticalSpace * 2
            ),
            episodeLabel.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor)
        ])
    }

    func updateBackgroundColor(highlighted: Bool) {
        backgroundColorView.backgroundColor = highlighted ? .highlightedColor : .backgroundColor
    }
}

// MARK: Constants
private extension ShowDetailEpisodeTableCell {
    struct Dimension {
        static let posterImageSize = CGSize(width: 125.0, height: 70.0)
        static let verticalSpace: CGFloat = 4.0
    }
}
