//
//  PostCell.swift
//  Platter
//
//  Created by Yuan Gao on 12/5/24.
//

import UIKit

class PostCell: UICollectionViewCell {

    // MARK: - Properties (view)
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Anonymous"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        return label
    } ()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1.0)
        return label
    } ()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Image")
        imageView.contentMode = .scaleAspectFill
        return imageView
    } ()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        return label
    } ()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.tintColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1.0)
        return button
    } ()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .black
        return label
    } ()

    // MARK: - Properties (data)

    static let reuse: String = "PostCollectionViewCellReuse"
    private let netID = "yg626"
    private var id: String = ""
    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        layer.cornerRadius = 16

        setupViews()
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Set Up Views

    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(messageLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(likesLabel)
    
        // Layout using AutoLayout
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 32),
            imageView.heightAnchor.constraint(equalToConstant: 32),

            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            likeButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),

            likesLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            likesLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 8),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
    
    func configure(with post: Post) {
        messageLabel.text = post.message
        dateLabel.text = "\(post.time.convertToAgo())"
        likesLabel.text = "\(post.likes.count) likes"
        id = post.id
        updateLikeButton(post: post)
    }
    
    private func updateLikeButton(post: Post) {
        if post.likes.contains(netID) {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = .red
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = .black
        }
    }
    
    // MARK: - Handle Like Button Tap
    @objc private func likeButtonTapped() {
        print("Like button tapped")
//        NetworkManager.shared.likePost(postID: id, netID: netID) { [weak self] response in
//            guard self != nil else { return }
//            print("Like request successful")
//        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layoutIfNeeded()
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
    }
}
