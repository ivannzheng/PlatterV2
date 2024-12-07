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

    private var isLiked: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }
    
    private func setupViews() {
        contentView.layer.cornerRadius = 16
        contentView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        
        avatarImageView.clipsToBounds = true
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.image = UIImage(systemName: "person.circle.fill")
        contentView.addSubview(avatarImageView)

        nameLabel.font = UIFont.avenirNext("Medium", size: 16)
        contentView.addSubview(nameLabel)

        timeLabel.font = .systemFont(ofSize: 12)
        timeLabel.textColor = .gray
        contentView.addSubview(timeLabel)

        titleLabel.font = UIFont.avenirNext("DemiBold", size: 16)
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)

        messageLabel.font = UIFont.avenirNext("Medium", size: 16)
        messageLabel.numberOfLines = 0
        contentView.addSubview(messageLabel)

        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .gray
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        contentView.addSubview(likeButton)

        commentButton.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        commentButton.tintColor = .gray
        contentView.addSubview(commentButton)

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
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),

            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),

            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            timeLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8),
            timeLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),

            titleLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),

            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            likeButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: -16),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            likeButton.widthAnchor.constraint(equalToConstant: 40),
            likeButton.heightAnchor.constraint(equalToConstant: 40),

            commentButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            commentButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 8),
            commentButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
    }

    func configure(with post: Post) {
        avatarImageView.sd_setImage(with: URL(string: post.avatar), placeholderImage: UIImage(systemName: "person.circle"))
        nameLabel.text = post.name
        timeLabel.text = post.time.convertToAgo()
        titleLabel.text = post.title
        messageLabel.text = post.description
    }

    @objc private func didTapLikeButton() {
        isLiked.toggle()
        let imageName = isLiked ? "heart.fill" : "heart"
        let tintColor: UIColor = isLiked ? .systemRed : .gray
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
        likeButton.tintColor = tintColor
    }
}
