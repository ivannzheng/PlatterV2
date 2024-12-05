//
//  ContainerViewController.swift
//  Platter
//
//  Created by Yuan Gao on 12/3/24.
//

import UIKit

class ContainerViewController: UIViewController {
    // MARK: - Properties
    private let bottomNavBar = UIView()
    private let navController = UINavigationController()
    private var selectedTab: Int = 0 // Track the selected tab
    
    // Main view controllers
    private let homeViewController = ViewController() // Home tab
    private let groupViewController = GroupViewController() // Groups tab
    private let profileViewController = ProfileViewController() // Profile tab
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Add subviews in correct order
        setupBottomNavBar()
        setupNavController()
        
        // Set default tab
        switchToViewController(homeViewController)
    }
    
    // MARK: - Setup Nav Controller
    private func setupNavController() {
        // Add navController's view to the hierarchy
        addChild(navController)
        navController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navController.view)
        navController.didMove(toParent: self)
        
        // Apply constraints for navController
        NSLayoutConstraint.activate([
            navController.view.topAnchor.constraint(equalTo: view.topAnchor),
            navController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navController.view.bottomAnchor.constraint(equalTo: bottomNavBar.topAnchor) // Link with bottomNavBar
        ])
    }
    
    // MARK: - Setup Bottom Nav Bar
    private func setupBottomNavBar() {
        // Add the bottom nav bar
        bottomNavBar.backgroundColor = UIColor(red: 232/255, green: 213/255, blue: 183/255, alpha: 1.0)
        bottomNavBar.layer.borderWidth = 0.5
        bottomNavBar.layer.borderColor = UIColor.black.cgColor
        bottomNavBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomNavBar)
        
        // Apply constraints for bottomNavBar
        NSLayoutConstraint.activate([
            bottomNavBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomNavBar.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        // Add buttons to the bottom nav bar
        let homeButton = createNavButton(icon: "house", action: #selector(didTapHome))
        let groupButton = createNavButton(icon: "person.3", action: #selector(didTapGroups))
        let profileButton = createNavButton(icon: "person", action: #selector(didTapProfile))
        
        let stackView = UIStackView(arrangedSubviews: [homeButton, groupButton, profileButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomNavBar.addSubview(stackView)
        
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
        config.imagePlacement = .top
        config.imagePadding = 10
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 0)
        config.baseForegroundColor = .black
        
        button.configuration = config
        button.addTarget(self, action: action, for: .touchUpInside)
        
        return button
    }
    
    // MARK: - Tab Switching
    private func switchToViewController(_ viewController: UIViewController) {
        navController.setViewControllers([viewController], animated: false)
    }
    
    // MARK: - Button Actions
    @objc private func didTapHome() {
        guard selectedTab != 0 else { return } // Prevent reload if already selected
        selectedTab = 0
        switchToViewController(homeViewController)
    }
    
    @objc private func didTapGroups() {
        guard selectedTab != 1 else { return } // Prevent reload if already selected
        selectedTab = 1
        switchToViewController(groupViewController)
    }
    
    @objc private func didTapProfile() {
        guard selectedTab != 2 else { return } // Prevent reload if already selected
        selectedTab = 2
        switchToViewController(profileViewController)
    }
}
