//
//  SummaryTableCell.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 28/05/22.
//

import UIKit

final class SummaryTableCell: UITableViewCell {
    // MARK: Properties
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Dimension.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let summaryTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldTitle
        label.numberOfLines = 1
        label.text = R.string.localizable.show_detail_summary()
        return label
    }()
    private let summaryDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .mediumRegular
        label.textAlignment = .justified
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
    func bind(summary: String?) {
        summaryDescriptionLabel.text = summary?.removeTags
    }
}

// MARK: Private methods
private extension SummaryTableCell {
    func setupUI() {
        selectionStyle = .none
        contentView.apply {
            $0.addSubview(verticalStackView.apply {
                $0.addArrangedSubview(summaryTitleLabel)
                $0.addArrangedSubview(summaryDescriptionLabel)
            })
        }
        verticalStackView.addConstraintsToFillSuperview(insets: Dimension.stackViewInsets)
    }
}

// MARK: Constants
private extension SummaryTableCell {
    struct Dimension {
        static let stackViewSpacing: CGFloat = 6.0
        static let stackViewInsets = UIEdgeInsets(
            top: 5.0,
            left: 10.0,
            bottom: 0.0,
            right: 10.0
        )
    }
}

// MARK: Util
private extension String {
    var removeTags: String? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding:String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            ).string
        } catch {
            return nil
        }
    }
}
