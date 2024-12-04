//
//  ViewController.swift
//  Platter
//
//  Created by Yuan Gao on 11/28/24.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties (view)
//    private let recommendCollectionView = UICollectionView()
//    private let feedCollectionView = UICollectionView()
    private let recommendedLabel = UILabel()
    private let feedLabel = UILabel()
    private let bottomNavBar = UIView()
    private let topBar = UIView()
    
    
    // MARK: - Properties (data)
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupTopBar()
        setupBottomNavBar()
        setupRecommendLabel()
    }
    
    // MARK: - Set Up Views
    private func setupBottomNavBar() {
        bottomNavBar.backgroundColor = .gray
        bottomNavBar.layer.borderWidth = 0.5
        bottomNavBar.layer.borderColor = UIColor.black.cgColor
        bottomNavBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomNavBar)
        
        NSLayoutConstraint.activate([
            bottomNavBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomNavBar.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        // Add buttons
        let homeButton = createNavButton(icon: "house", action: #selector(homeTapped))
        let myClubsButton = createNavButton(icon: "gift", action: #selector(recommendTapped))
        let profileButton = createNavButton(icon: "person", action: #selector(profileTapped))
        
        let stackView = UIStackView(arrangedSubviews: [homeButton, myClubsButton, profileButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomNavBar.addSubview(stackView)
        
        // Constraints for stack view
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: bottomNavBar.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: bottomNavBar.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: bottomNavBar.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomNavBar.bottomAnchor)
        ])
    }
    
    private func createNavButton(icon: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: icon)
        config.imagePlacement = .top // Place the image above the text
        config.imagePadding = 10
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 0)
        config.baseForegroundColor = .black // Set the icon color
        
        button.configuration = config
        button.addTarget(self, action: action, for: .touchUpInside)
        
        return button
    }
    
    private func setupTopBar() {
        // Configure the top bar
        topBar.backgroundColor = .gray
        topBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBar)
        
        // Constraints for the top bar
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.topAnchor),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBar.heightAnchor.constraint(equalToConstant: 100) // Adjust height as needed
        ])
        
        // Logo Image
        let logoImageView = UIImageView(image: UIImage(systemName: "star")) // Replace with your logo image
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // App Name Label
        let appNameLabel = UILabel()
        appNameLabel.text = "App Name" // Replace with your app name
        appNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        appNameLabel.textAlignment = .center
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Search Button
        let searchButton = UIButton(type: .system)
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .black
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        // Add subviews to the top bar
        topBar.addSubview(logoImageView)
        topBar.addSubview(appNameLabel)
        topBar.addSubview(searchButton)
        
        // Constraints for logo
        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: topBar.leadingAnchor, constant: 10),
            logoImageView.centerYAnchor.constraint(equalTo: topBar.centerYAnchor, constant: 30),
            logoImageView.widthAnchor.constraint(equalToConstant: 30), // Adjust size as needed
            logoImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // Constraints for app name
        NSLayoutConstraint.activate([
            appNameLabel.centerXAnchor.constraint(equalTo: topBar.centerXAnchor),
            appNameLabel.centerYAnchor.constraint(equalTo: topBar.centerYAnchor, constant: 30)
        ])
        
        // Constraints for search button
        NSLayoutConstraint.activate([
            searchButton.trailingAnchor.constraint(equalTo: topBar.trailingAnchor, constant: -10),
            searchButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor, constant: 30),
            searchButton.widthAnchor.constraint(equalToConstant: 30),
            searchButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupRecommendLabel() {
        recommendedLabel.text = "Recommended"
        recommendedLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        recommendedLabel.textColor = .black
        recommendedLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recommendedLabel)
        
        NSLayoutConstraint.activate([
            recommendedLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            recommendedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
        ])
    }
    
    private func setupFeedLabel() {
        
    }
    
    // MARK: - Button Actions
    @objc private func homeTapped() {
        print("Home tapped")
    }
    
    @objc private func recommendTapped() {
        print("Recommend tapped")
    }
    
    @objc private func profileTapped() {
        print("Profile tapped")
    }
    
    @objc private func searchButtonTapped() {
        print("Search button tapped")
    }
    
    // MARK: - UICollectionViewDelegate
    
    // MARK: - UICollectionViewDataSource
    
    // MARK: - UICollectionViewDelegateFlowLayout
}

