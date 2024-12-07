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
    private var selectedTab: Int = 0
    private var homeButton: UIButton!
    private var groupButton: UIButton!
    private var profileButton: UIButton!
    
    private let homeViewController = ViewController()
    private let groupViewController = GroupViewController()
    private let profileViewController = ProfileViewController()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupBottomNavBar()
        setupNavController()

        switchToViewController(homeViewController)
        updateButtonStates(selectedButton: homeButton)
    }

    // MARK: - Setup Nav Controller
    private func setupNavController() {
        addChild(navController)
        navController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navController.view)
        navController.didMove(toParent: self)

        NSLayoutConstraint.activate([
            navController.view.topAnchor.constraint(equalTo: view.topAnchor),
            navController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navController.view.bottomAnchor.constraint(equalTo: bottomNavBar.topAnchor)
        ])
    }

    // MARK: - Setup Bottom Nav Bar
    private func setupBottomNavBar() {
        bottomNavBar.backgroundColor = UIColor(red: 232/255, green: 213/255, blue: 183/255, alpha: 1.0)
        bottomNavBar.layer.borderWidth = 0.5
        bottomNavBar.layer.borderColor = UIColor.gray.cgColor
        bottomNavBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomNavBar)

        NSLayoutConstraint.activate([
            bottomNavBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomNavBar.heightAnchor.constraint(equalToConstant: 75)
        ])

        homeButton = createNavButton(icon: "house", action: #selector(didTapHome))
        groupButton = createNavButton(icon: "person.3", action: #selector(didTapGroups))
        profileButton = createNavButton(icon: "person", action: #selector(didTapProfile))

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

    // MARK: - Update Button States
    private func updateButtonStates(selectedButton: UIButton) {
        homeButton.configuration?.image = UIImage(systemName: "house")
        groupButton.configuration?.image = UIImage(systemName: "person.3")
        profileButton.configuration?.image = UIImage(systemName: "person")
        
        homeButton.tintColor = .gray
        groupButton.tintColor = .gray
        profileButton.tintColor = .gray
        
        selectedButton.configuration?.image = {
            switch selectedButton {
            case homeButton: return UIImage(systemName: "house.fill")
            case groupButton: return UIImage(systemName: "person.3.fill")
            case profileButton: return UIImage(systemName: "person.fill")
            default: return nil
            }
        }()
        
        selectedButton.tintColor = .systemBlue
    }

    // MARK: - Tab Switching
    private func switchToViewController(_ viewController: UIViewController) {
        navController.setViewControllers([viewController], animated: false)
    }

    // MARK: - Button Actions
    @objc private func didTapHome() {
        guard selectedTab != 0 else { return }
        selectedTab = 0
        switchToViewController(homeViewController)
        updateButtonStates(selectedButton: homeButton)
    }

    @objc private func didTapGroups() {
        guard selectedTab != 1 else { return }
        selectedTab = 1
        switchToViewController(groupViewController)
        updateButtonStates(selectedButton: groupButton)
    }

    @objc private func didTapProfile() {
        guard selectedTab != 2 else { return }
        selectedTab = 2
        switchToViewController(profileViewController)
        updateButtonStates(selectedButton: profileButton)
    }
}
