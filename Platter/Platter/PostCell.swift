//
//  PostCell.swift
//  Platter
//
//  Created by Yuan Gao on 12/5/24.
//

import UIKit

class PostCell: UICollectionViewCell {
    static let reuseIdentifier = "PostCell"

    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let timeLabel = UILabel()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let likeButton = UIButton()
    private let commentButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        // Avatar
        avatarImageView.layer.cornerRadius = 20
        avatarImageView.clipsToBounds = true
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.image = UIImage(systemName: "person.circle.fill") // Placeholder avatar
        contentView.addSubview(avatarImageView)

        // Name Label
        nameLabel.font = .boldSystemFont(ofSize: 14)
        contentView.addSubview(nameLabel)

        // Time Label
        timeLabel.font = .systemFont(ofSize: 12)
        timeLabel.textColor = .gray
        contentView.addSubview(timeLabel)

        // Title Label
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 1
        contentView.addSubview(titleLabel)

        // Message Label
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.numberOfLines = 0
        contentView.addSubview(messageLabel)

        // Like Button
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .gray
        contentView.addSubview(likeButton)

        // Comment Button
        commentButton.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        commentButton.tintColor = .gray
        contentView.addSubview(commentButton)

        // Constraints
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        commentButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 40),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),

            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),

            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            timeLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8),
            timeLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),

            titleLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            likeButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

            commentButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            commentButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 16)
        ])
    }

    func configure(with post: Post) {
        avatarImageView.sd_setImage(with: URL(string: post.avatar), placeholderImage: UIImage(systemName: "person.circle"))
        nameLabel.text = post.name
        timeLabel.text = DateFormatter.localizedString(from: post.time, dateStyle: .none, timeStyle: .short)
        titleLabel.text = post.title
        messageLabel.text = post.description
    }
}
