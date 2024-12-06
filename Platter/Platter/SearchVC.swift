//
//  SearchVC.swift
//  Platter
//
//  Created by Yuan Gao on 12/6/24.
//
import UIKit

class SearchVC: UIViewController {
    private let header = UIView()
    private let searchTextField = UITextField()
    private let backButton = UIButton()
    private let recentSearchLabel = UILabel()
    private var filtersCollectionView: UICollectionView!
    private var recentSearchesTableView: UITableView!
    private var filteredRecipesCollectionView: UICollectionView!
    
    // MARK: - Data
    private var filters: [String] = ["Vegetarian", "Meats", "Grilled", "Healthy", "Soup"]
    private var selectedFilters: [Bool] = []
    private var recentSearches: [Recipe] = Recipe.loadRecipes()
    private var filteredRecipes: [Recipe] = []
    private var selectedFiltersList: [String] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Initialize the selectedFilters array
        selectedFilters = Array(repeating: false, count: filters.count)

        // Remove the default back button
        navigationItem.hidesBackButton = true

        setupHeader()
        setupBackButtonAndSearchBar() // Combined back button and search bar
        setupFiltersCollectionView()
        setupSearchLabel()
        setupRecentSearchesTableView()
        setupFilteredRecipesCollectionView()
    }

    // MARK: - Setup Views
    private func setupHeader() {
        header.backgroundColor = UIColor(red: 236 / 255, green: 159 / 255, blue: 5 / 255, alpha: 1.0)
        header.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(header)

        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: 150)
        ])
    }

    private func setupBackButtonAndSearchBar() {
        // Back Button
        backButton.setImage(UIImage(named: "arrow"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)

        // Set backButton as the leftBarButtonItem
        let backButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backButtonItem

        // Search Bar
        searchTextField.placeholder = "Search"
        searchTextField.backgroundColor = UIColor(red: 232 / 255, green: 213 / 255, blue: 183 / 255, alpha: 1.0)
        searchTextField.layer.cornerRadius = 16
        searchTextField.leftView = UIImageView(image: UIImage(systemName: "magnifyingglass"))

        searchTextField.leftViewMode = .always
        searchTextField.tintColor = .black
        searchTextField.translatesAutoresizingMaskIntoConstraints = false

        // Create a container for the search bar to add it as the titleView
        let searchContainer = UIView()
        searchContainer.translatesAutoresizingMaskIntoConstraints = false
        searchContainer.addSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: searchContainer.topAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: searchContainer.bottomAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: searchContainer.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: searchContainer.trailingAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: 40)
        ])

        // Set the container view as the navigation item's titleView
        navigationItem.titleView = searchContainer

        // Adjust the searchContainer size
        searchContainer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 56).isActive = true // Adjust width
        searchContainer.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    @objc private func popVC() {
        // Navigate back to the previous view controller
        navigationController?.popViewController(animated: true)
    }

    private func setupFiltersCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8


        filtersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        filtersCollectionView.backgroundColor = .clear
        filtersCollectionView.showsHorizontalScrollIndicator = false
        filtersCollectionView.delegate = self
        filtersCollectionView.dataSource = self
        filtersCollectionView.register(FilterCell.self, forCellWithReuseIdentifier: FilterCell.reuseIdentifier)
        filtersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filtersCollectionView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        view.addSubview(filtersCollectionView)

        NSLayoutConstraint.activate([
            filtersCollectionView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 12),
            filtersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filtersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filtersCollectionView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupSearchLabel() {
        recentSearchLabel.text = "Recent searches"
        recentSearchLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        recentSearchLabel.textColor = .black
        recentSearchLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recentSearchLabel)
        
        NSLayoutConstraint.activate([
            recentSearchLabel.topAnchor.constraint(equalTo: filtersCollectionView.bottomAnchor, constant: 24),
            recentSearchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            recentSearchLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func setupRecentSearchesTableView() {
        recentSearchesTableView = UITableView()
        recentSearchesTableView.delegate = self
        recentSearchesTableView.dataSource = self
        recentSearchesTableView.register(RecentSearchCell.self, forCellReuseIdentifier: RecentSearchCell.reuseIdentifier)
        recentSearchesTableView.translatesAutoresizingMaskIntoConstraints = false
        recentSearchesTableView.rowHeight = 60

        view.addSubview(recentSearchesTableView)

        NSLayoutConstraint.activate([
            recentSearchesTableView.topAnchor.constraint(equalTo: recentSearchLabel.bottomAnchor, constant: 24),
            recentSearchesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recentSearchesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recentSearchesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupFilteredRecipesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        filteredRecipesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        filteredRecipesCollectionView.backgroundColor = .clear
        filteredRecipesCollectionView.showsVerticalScrollIndicator = false
        filteredRecipesCollectionView.delegate = self
        filteredRecipesCollectionView.dataSource = self
        filteredRecipesCollectionView.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.reuseIdentifier)
        filteredRecipesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filteredRecipesCollectionView.isHidden = true // Start as hidden

        view.addSubview(filteredRecipesCollectionView)

        NSLayoutConstraint.activate([
            filteredRecipesCollectionView.topAnchor.constraint(equalTo: filtersCollectionView.bottomAnchor, constant: 24),
            filteredRecipesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            filteredRecipesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            filteredRecipesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchCell.reuseIdentifier, for: indexPath) as! RecentSearchCell
        let recipe = recentSearches[indexPath.row]
        cell.configure(with: recipe.imageUrl, title: recipe.title)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = recentSearches[indexPath.row]
        let detailVC = RecipeDetailViewController()
        detailVC.recipe = selectedRecipe
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension SearchVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == filtersCollectionView {
            return filters.count
        } else if collectionView == filteredRecipesCollectionView {
            return filteredRecipes.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == filtersCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.reuseIdentifier, for: indexPath) as! FilterCell
            let isSelected = selectedFiltersList.contains(filters[indexPath.item])
            cell.configure(with: filters[indexPath.item], isSelected: isSelected)
            cell.delegate = self
            return cell
        } else if collectionView == filteredRecipesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.reuseIdentifier, for: indexPath) as! RecipeCell
            let recipe = filteredRecipes[indexPath.item]
            cell.configure(with: recipe, isBookmarked: recipe.saved)
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == filtersCollectionView {
            let text = filters[indexPath.item]
            let textWidth = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]).width
            return CGSize(width: textWidth + 16, height: 32)
        } else if collectionView == filteredRecipesCollectionView {
            let width = (collectionView.frame.width - 32) / 2 // Two columns
            return CGSize(width: width, height: width) // Adjust height for title
        }
        return CGSize.zero
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == filteredRecipesCollectionView {
            let selectedRecipe = filteredRecipes[indexPath.item]
            let detailVC = RecipeDetailViewController()
            detailVC.recipe = selectedRecipe
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

// MARK: - FilterCellDelegate
extension SearchVC: FilterCellDelegate {
    func didTapFilterButton(title: String) {
        if let index = filters.firstIndex(of: title) {
            // Toggle selection
            if selectedFiltersList.contains(title) {
                selectedFiltersList.removeAll { $0 == title }
            } else {
                selectedFiltersList.append(title)
            }

            // Update filtered recipes or show recent searches
            if selectedFiltersList.isEmpty {
                // Show recent searches if no filters are selected
                filteredRecipesCollectionView.isHidden = true
                recentSearchesTableView.isHidden = false
                recentSearchLabel.isHidden = false
            } else {
                // Filter recipes that match any selected filters
                filteredRecipes = recentSearches.filter { selectedFiltersList.contains($0.type) }
                recentSearchesTableView.isHidden = true
                recentSearchLabel.isHidden = true
                filteredRecipesCollectionView.isHidden = false
                filteredRecipesCollectionView.reloadData()
            }

            // Reload the collection view to update cell appearance
            filtersCollectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
        }
    }
}
