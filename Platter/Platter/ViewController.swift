//
//  ViewController.swift
//  Platter
//
//  Created by Yuan Gao on 11/28/24.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties (view)
    private let recommendedLabel = UILabel()
    private let feedLabel = UILabel()
    private let topBar = UIView()
    private let header = UIView()
    private let titleLabel = UILabel()
    private let logoImageView = UIImageView()
    private let searchButton = UIButton()
    private let inSeasonLabel = UILabel()
    private let groupLabel = UILabel()
    private var collectionView1: UICollectionView!
    private var collectionView2: UICollectionView!
    private var collectionView3: UICollectionView!
    
    // MARK: - Properties (data)
    private var recipes: [Recipe] = Recipe.loadRecipes()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupHeader()
        setupSearchButton()
        setupLogo()
        setupTitle()
        setupRecommendLabel()
        setupCollectionView1()
        setupInSeasonLabel()
        setupCollectionView2()
        setupGroupsLabel()
        setupCollectionView3()
        
        NotificationCenter.default.addObserver(self, selector: #selector(bookmarkUpdated), name: NSNotification.Name("BookmarkUpdated"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        setupSearchButton()
    }

    // MARK: - Set Up Views
    private func setupHeader() {
        header.backgroundColor = UIColor(red: 236/255, green: 159/255, blue: 5/255, alpha: 1.0)
        header.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(header)
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: 140)
        ])
    }

    private func setupLogo() {
        logoImageView.image = UIImage(named: "logo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        header.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 24),
            logoImageView.centerYAnchor.constraint(equalTo: header.centerYAnchor, constant: 45),
            logoImageView.widthAnchor.constraint(equalToConstant: 40),
            logoImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupTitle() {
        titleLabel.text = "Platter"
        titleLabel.font = UIFont.avenirNext("DemiBold", size: 24)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        header.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: header.centerYAnchor, constant: 45)
        ])
    }

    private func setupSearchButton() {
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .black
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        searchButton.contentEdgeInsets = UIEdgeInsets(top: -10, left: 0, bottom: 5, right: 0)
        NSLayoutConstraint.activate([
            searchButton.widthAnchor.constraint(equalToConstant: 30),
            searchButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        navigationController?.navigationBar.layoutMargins = UIEdgeInsets(top: -30, left: 0, bottom: 10, right: 0)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        
        
        let uiBarButtonItem = UIBarButtonItem(customView: searchButton)
        navigationItem.rightBarButtonItem = uiBarButtonItem
    }
    
    @objc private func searchButtonTapped() {
        let searchVC = SearchVC()
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    private func setupRecommendLabel() {
        recommendedLabel.text = "Recommended For You"
        recommendedLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        recommendedLabel.textColor = .black
        recommendedLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recommendedLabel)
        
        NSLayoutConstraint.activate([
            recommendedLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 8),
            recommendedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
        ])
    }
    
    private func setupInSeasonLabel() {
        inSeasonLabel.text = "Just in Season"
        inSeasonLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        inSeasonLabel.textColor = .black
        view.addSubview(inSeasonLabel)
        inSeasonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            inSeasonLabel.topAnchor.constraint(equalTo: collectionView1.bottomAnchor, constant: 24),
            inSeasonLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
        ])
    }
    
    private func setupGroupsLabel() {
        groupLabel.text = "Explore More"
        groupLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        groupLabel.textColor = .black
        view.addSubview(groupLabel)
        groupLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            groupLabel.topAnchor.constraint(equalTo: collectionView2.bottomAnchor, constant: 24),
            groupLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
        ])
    }
    
    private func setupCollectionView1() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 24
        collectionView1 = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView1.showsHorizontalScrollIndicator = false
        collectionView1.delegate = self
        collectionView1.dataSource = self
        collectionView1.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.reuseIdentifier)
        collectionView1.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        collectionView1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView1)

        NSLayoutConstraint.activate([
            collectionView1.topAnchor.constraint(equalTo: recommendedLabel.bottomAnchor, constant: 16),
            collectionView1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView1.heightAnchor.constraint(equalToConstant: 160)
        ])
    }

    private func setupCollectionView2() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 24
        collectionView2 = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView2.showsHorizontalScrollIndicator = false
        collectionView2.delegate = self
        collectionView2.dataSource = self
        collectionView2.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.reuseIdentifier)
        collectionView2.translatesAutoresizingMaskIntoConstraints = false
        collectionView2.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        view.addSubview(collectionView2)

        NSLayoutConstraint.activate([
            collectionView2.topAnchor.constraint(equalTo: inSeasonLabel.bottomAnchor, constant: 16),
            collectionView2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView2.heightAnchor.constraint(equalToConstant: 160)
        ])
    }

    private func setupCollectionView3() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 24
        collectionView3 = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView3.showsHorizontalScrollIndicator = false
        collectionView3.delegate = self
        collectionView3.dataSource = self
        collectionView3.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.reuseIdentifier)
        collectionView3.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        collectionView3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView3)
        
        NSLayoutConstraint.activate([
            collectionView3.topAnchor.constraint(equalTo: groupLabel.bottomAnchor, constant: 16),
            collectionView3.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView3.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView3.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    @objc private func bookmarkUpdated() {
        collectionView1.reloadData()
        collectionView2.reloadData()
        collectionView3.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Check which collectionView is being handled
        if collectionView == collectionView1 {
            return recipes.filter { $0.id == "1" || $0.id == "2" || $0.id == "7"}.count
        } else if collectionView == collectionView2 {
            return recipes.filter { $0.id == "3" || $0.id == "4" || $0.id == "8" }.count
        } else if collectionView == collectionView3 {
            return recipes.filter { $0.id == "5" || $0.id == "6" || $0.id == "9"}.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.reuseIdentifier, for: indexPath) as? RecipeCell else {
            return UICollectionViewCell()
        }
        
        let filteredRecipes: [Recipe]
        if collectionView == collectionView1 {
            filteredRecipes = recipes.filter { $0.id == "1" || $0.id == "2" || $0.id == "7"}
        } else if collectionView == collectionView2 {
            filteredRecipes = recipes.filter { $0.id == "3" || $0.id == "4" || $0.id == "8"}
        } else {
            filteredRecipes = recipes.filter { $0.id == "5" || $0.id == "6" || $0.id == "9"}
        }
        
        let recipe = filteredRecipes[indexPath.item]
        
        let savedBookmarks = UserDefaults.standard.array(forKey: "bookmarkedRecipes") as? [String] ?? []
        let isBookmarked = savedBookmarks.contains(recipe.id)
    
        cell.configure(with: recipe, isBookmarked: isBookmarked)
        cell.delegate = self
        return cell
    }
}
    
// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filteredRecipes: [Recipe]
        
        if collectionView == collectionView1 {
            filteredRecipes = recipes.filter { $0.id == "1" || $0.id == "2" || $0.id == "7"}
        } else if collectionView == collectionView2 {
            filteredRecipes = recipes.filter { $0.id == "3" || $0.id == "4" || $0.id == "8"}
        } else {
            filteredRecipes = recipes.filter { $0.id == "5" || $0.id == "6" || $0.id == "9"}
        }
        
        let recipe = filteredRecipes[indexPath.item]
        let detailVC = RecipeDetailViewController()
        detailVC.recipe = recipe
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
    }
}

extension ViewController: RecipeCellDelegate {
    func didTapBookmark(for cell: RecipeCell) {
        guard let indexPath = collectionView1.indexPath(for: cell) else { return }
        var recipe = recipes[indexPath.item]
        var savedBookmarks = UserDefaults.standard.array(forKey: "bookmarkedRecipes") as? [String] ?? []
        if savedBookmarks.contains(recipe.id) {
            savedBookmarks.removeAll { $0 == recipe.id }
        } else {
            savedBookmarks.append(recipe.id)
        }
        
        recipe.saved.toggle()
        recipes[indexPath.item] = recipe
        Recipe.saveRecipes(recipes)
        UserDefaults.standard.set(savedBookmarks, forKey: "bookmarkedRecipes")
        collectionView1.reloadItems(at: [indexPath])
    }
}
