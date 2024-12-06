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

    // MARK: - Data
    private var filters: [String] = ["Vegetarian", "Meats", "Grilled", "Healthy", "Soup"]
    private var selectedFilters: [Bool] = []
    private var recentSearches: [Recipe] = Recipe.loadRecipes()

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
        return filters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.reuseIdentifier, for: indexPath) as! FilterCell
        let isSelected = selectedFilters[indexPath.item]
        cell.configure(with: filters[indexPath.item], isSelected: isSelected)
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = filters[indexPath.item]
        // Calculate the text width with padding
        let textWidth = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]).width
        let cellWidth = textWidth + 16 // Add padding (16px left + 16px right)
        return CGSize(width: cellWidth, height: 32) // Height stays fixed
    }
}

// MARK: - FilterCellDelegate
extension SearchVC: FilterCellDelegate {
    func didTapFilterButton(title: String) {
        if let index = filters.firstIndex(of: title) {
            selectedFilters[index].toggle()
            filtersCollectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
        }
    }
}
