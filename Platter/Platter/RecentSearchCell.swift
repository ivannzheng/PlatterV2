//
//  RecentSearchCell.swift
//  Platter
//
//  Created by Yuan Gao on 12/6/24.
//

import UIKit
import SDWebImage

class RecentSearchCell: UITableViewCell {
    private let thumbnailImageView = UIImageView()
    private let titleLabel = UILabel()
    private let removeButton = UIButton(type: .system)
    static let reuseIdentifier = "RecentSearchCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        thumbnailImageView.layer.cornerRadius = 8
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        removeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        removeButton.tintColor = .black
        removeButton.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(removeButton)

        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            thumbnailImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 40),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 40),

            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            removeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            removeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with imageUrl: String, title: String) {
        thumbnailImageView.sd_setImage(with: URL(string: imageUrl))
        titleLabel.text = title
    }
}
