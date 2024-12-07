//
//  RecipeCell.swift
//  Platter
//
//  Created by Yuan Gao on 12/2/24.
//

import UIKit
import SDWebImage

class RecipeCell: UICollectionViewCell {
    static let reuseIdentifier: String = "RecipeCell"
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    let bookmarkButton = UIButton(type: .system)
    weak var delegate: RecipeCellDelegate?
    
    private var recipe: Recipe?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        //setupTitleLabel()
        setupBookmarkButton()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with recipe: Recipe, isBookmarked: Bool) {
        self.recipe = recipe
        titleLabel.text = recipe.title
        imageView.sd_setImage(with: URL(string: recipe.imageUrl))
        let bookmarkImage = UIImage(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
        bookmarkButton.setImage(bookmarkImage, for: .normal)
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 160),
            imageView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 3
        titleLabel.layer.shadowColor = UIColor.black.cgColor // Optional shadow
        titleLabel.layer.shadowOpacity = 0.8
        titleLabel.layer.shadowOffset = CGSize(width: 0, height: 1)
        titleLabel.layer.shadowRadius = 2
        imageView.addSubview(titleLabel) // Adding titleLabel directly to imageView
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: imageView.trailingAnchor, constant: -25)
        ])
    }
    
    private func setupBookmarkButton() {
        let bookmarkImage = UIImage(systemName: "bookmark")?.withRenderingMode(.alwaysTemplate)
        bookmarkButton.setImage(bookmarkImage, for: .normal)
        bookmarkButton.tintColor = .white
        bookmarkButton.addTarget(self, action: #selector(bookmarkTapped), for: .touchUpInside)
        bookmarkButton.isUserInteractionEnabled = true
        imageView.addSubview(bookmarkButton)
        
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookmarkButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            bookmarkButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 24),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    @objc private func bookmarkTapped() {
        delegate?.didTapBookmark(for: self) 
    }
}

protocol RecipeCellDelegate: AnyObject {
    func didTapBookmark(for cell: RecipeCell)
}
