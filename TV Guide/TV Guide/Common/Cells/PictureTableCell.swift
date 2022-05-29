//
//  PictureTableCell.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 29/05/22.
//

import Kingfisher
import UIKit

final class PictureTableCell: UITableViewCell {
    // MARK: Properties
    private let pictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        pictureImageView.kf.cancelDownloadTask()
    }

    // MARK: Public methods
    func bind(imageURL: URL) {
        pictureImageView.kf.setImage(with: imageURL, options: [.transition(.fade(Constants.imageFadeIn))])
    }
}

// MARK: Private methods
private extension PictureTableCell {
    func setupUI() {
        selectionStyle = .none
        contentView.apply {
            $0.addSubview(pictureImageView)
        }
        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            pictureImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.defaultHorizontalSpace
            ),
            pictureImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pictureImageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.defaultHorizontalSpace
            ),
            pictureImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            pictureImageView.heightAnchor.constraint(
                equalTo: pictureImageView.widthAnchor,
                multiplier: Dimension.aspectRatio
            ).apply {
                $0.priority = .defaultHigh
            }
        ])
    }
}

private extension PictureTableCell {
    struct Dimension {
        static let aspectRatio: CGFloat = 9/16
    }
}
