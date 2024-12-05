//
//  RecipeCellDetail.swift
//  Platter
//
//  Created by Yuan Gao on 12/3/24.
//

import UIKit
import SDWebImage

class RecipeDetailViewController: UIViewController {
    
    // MARK: - Properties
    var recipe: Recipe?
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let headerView = UIView()
    private let titleLabel = UILabel()
    private let summaryLabel = UILabel()
    private let imageStackView = UIStackView()
    
    private let ingredientsTitleLabel = UILabel()
    private let ingredientsLabel = UILabel()
    
    private let instructionsTitleLabel = UILabel()
    private let instructionsLabel = UILabel()
    
    private let backButton = UIButton()
    private let bookmarkButton = UIButton()
    var isBookmarked: Bool = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white



        setupHeaderView() // First, set up the header view
        setupScrollView() // Then, set up the scroll view below it
        setupBookmark()
        setupBackButton()
        setupSummaryLabel()
        setupPictures()
        setupIngredientsSection()
        setupInstructionsSection()
        populateData()
    }
    
    // MARK: - Setup ScrollView
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor), // Start below headerView
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    // MARK: - Setup Header View
    private func setupHeaderView() {
        headerView.backgroundColor = UIColor(red: 0.925, green: 0.624, blue: 0.019, alpha: 1.0)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView) // Add to the main view

        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor), // Pin to the top of the view
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),

            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupBackButton() {
        backButton.setImage(UIImage(named: "arrow"), for: .normal)
        backButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        backButton.clipsToBounds = true
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 12),
            backButton.heightAnchor.constraint(equalToConstant: 24),
        ])

        let BarButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = BarButton
    }
    
    private func setupBookmark() {
        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        bookmarkButton.tintColor = .black
        headerView.addSubview(bookmarkButton)
        bookmarkButton.addTarget(self, action: #selector(didTapBookmark), for: .touchUpInside)
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookmarkButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            bookmarkButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -24),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 24),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bookmarkButton)
    }
    
    private func setupIngredientsSection() {
        ingredientsTitleLabel.text = "Ingredients"
        ingredientsTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        ingredientsTitleLabel.textColor = .black
        ingredientsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(ingredientsTitleLabel)
        
        ingredientsLabel.font = UIFont.systemFont(ofSize: 14)
        ingredientsLabel.textColor = .black
        ingredientsLabel.numberOfLines = 0
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(ingredientsLabel)
        
        NSLayoutConstraint.activate([
            ingredientsTitleLabel.topAnchor.constraint(equalTo: imageStackView.bottomAnchor, constant: 16),
            ingredientsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            ingredientsLabel.topAnchor.constraint(equalTo: ingredientsTitleLabel.bottomAnchor, constant: 8),
            ingredientsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ingredientsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    // MARK: - Setup Instructions Section
    private func setupInstructionsSection() {
        instructionsTitleLabel.text = "Instructions"
        instructionsTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        instructionsTitleLabel.textColor = .black
        instructionsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(instructionsTitleLabel)
        
        instructionsLabel.font = UIFont.systemFont(ofSize: 14)
        instructionsLabel.textColor = .black
        instructionsLabel.numberOfLines = 0
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(instructionsLabel)
        
        NSLayoutConstraint.activate([
            instructionsTitleLabel.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 16),
            instructionsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            instructionsLabel.topAnchor.constraint(equalTo: instructionsTitleLabel.bottomAnchor, constant: 8),
            instructionsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            instructionsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            instructionsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    
    // MARK: - Bookmark Action
    @objc private func didTapBookmark() {
        isBookmarked.toggle()

        let bookmarkImageName = isBookmarked ? "bookmark.fill" : "bookmark"
        bookmarkButton.setImage(UIImage(systemName: bookmarkImageName), for: .normal)

        // Save bookmark in UserDefaults
        guard var recipe = recipe else { return }
        var savedBookmarks = UserDefaults.standard.array(forKey: "bookmarkedRecipes") as? [String] ?? []
        if isBookmarked {
            savedBookmarks.append(recipe.id)
        } else {
            savedBookmarks.removeAll { $0 == recipe.id }
        }
        recipe.saved = isBookmarked
        UserDefaults.standard.set(savedBookmarks, forKey: "bookmarkedRecipes")
        var savedRecipes = Recipe.loadRecipes()
        if let index = savedRecipes.firstIndex(where: { $0.id == recipe.id }) {
            savedRecipes[index] = recipe
            Recipe.saveRecipes(savedRecipes)
        }
        // Notify other views about the bookmark change
        NotificationCenter.default.post(name: NSNotification.Name("BookmarkUpdated"), object: nil)
    }

    // MARK: - Back Button Action
    @objc private func popVC() {
        navigationController?.popViewController(animated: true)
    }

    private func setupSummaryLabel() {
        summaryLabel.font = UIFont.systemFont(ofSize: 14)
        summaryLabel.textColor = .darkGray
        summaryLabel.numberOfLines = 0
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(summaryLabel)
        
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupPictures() {
        imageStackView.axis = .horizontal
        imageStackView.distribution = .fillEqually
        imageStackView.spacing = 8
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageStackView)
        
        NSLayoutConstraint.activate([
            imageStackView.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 16),
            imageStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageStackView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    // MARK: - Populate Data
    private func populateData() {
        guard let recipe = recipe else { return }
        titleLabel.text = recipe.title
        summaryLabel.text = recipe.summary
        
        // Check bookmark status
        let savedBookmarks = UserDefaults.standard.array(forKey: "bookmarkedRecipes") as? [String] ?? []
        isBookmarked = savedBookmarks.contains(recipe.id)
        updateBookmarkButton()
        
        // Load sample images in the stack view
        for _ in 0..<3 {
            let imageView = UIImageView()
            imageView.sd_setImage(with: URL(string: recipe.imageUrl), placeholderImage: UIImage(named: "placeholder"))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 8
            imageStackView.addArrangedSubview(imageView)
        }
        
        ingredientsLabel.text = recipe.ingredients.map { "• \($0)" }.joined(separator: "\n")
        instructionsLabel.text = recipe.instructions.enumerated().map { "\($0.offset + 1). \($0.element)" }.joined(separator: "\n")
    }

    private func updateBookmarkButton() {
        let bookmarkImageName = isBookmarked ? "bookmark.fill" : "bookmark"
        bookmarkButton.setImage(UIImage(systemName: bookmarkImageName), for: .normal)
    }
}
