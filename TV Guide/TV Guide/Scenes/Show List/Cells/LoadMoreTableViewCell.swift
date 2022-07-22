//
//  LoadMoreTableViewCell.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 28/05/22.
//

import UIKit

final class LoadMoreTableViewCell: UITableViewCell {
    private let indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        return indicator
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        indicatorView.center = contentView.center
        indicatorView.startAnimating()
    }

    func stopAnimating() {
        indicatorView.stopAnimating()
    }
}

private extension LoadMoreTableViewCell {
    func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(indicatorView)
    }
}
