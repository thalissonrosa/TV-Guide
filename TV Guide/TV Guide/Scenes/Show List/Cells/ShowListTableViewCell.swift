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
        stackView.spacing = Dimension.stackViewSpacing
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
    func bind(show: ShowLite) {
        showNameLabel.text = show.name
        guard let url = URL(string: show.image.medium) else { return }
        posterImageView.kf.setImage(with: url, options: [.transition(.fade(Constant.imageFadeIn))])
    }
}

// MARK: Private methods
private extension ShowListTableViewCell {
    func setupUI() {
        contentView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(posterImageView)
        containerStackView.addArrangedSubview(showNameLabel)
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
        static let stackViewSpacing: CGFloat = 10.0
        static let posterImageRatio: CGFloat = 210/295
    }

    struct Constant {
        static let imageFadeIn: TimeInterval = 0.3
    }
}
