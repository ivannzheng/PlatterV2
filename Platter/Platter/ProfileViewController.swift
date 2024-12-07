//  ProfileViewController.swift
//  Platter
//
//  Created by Yuan Gao on 12/3/24.
//
import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties (view)
    
    private let profilePic = UIImageView()
    private let header = UIView()
    private var nameLabel = UILabel()
    private var usernameLabel = UILabel()
    private let editProfileButton = UIButton()
    private let interestsLabel = UILabel()
    private var interestsCollectionView: UICollectionView!
    private let savedRecipesLabel = UILabel()
    private var savedRecipesCollectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    private let logoImageView = UIImageView()
    
    // MARK: - Properties (data)
    private var interests: [String] = ["Vegan", "Baking", "Vegetarian", "Quick", "Budget-free","Healthy", "Holiday", "+"]
    private var savedRecipes: [Recipe] = Recipe.loadRecipes().filter { $0.saved }
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupHeader()
        setupProfilePic()
        setupNameLabel()
        setupUsernameLabel()
        setupEditProfileButton()
        setupInterestsLabel()
        setupInterestsCollectionView()
        setupSavedRecipesLabel()
        setupSavedRecipesCollectionView()
        setupLogo()
        
        nameLabel.text = UserDefaults.standard.string(forKey: "name") ?? "Angela Wang"
        usernameLabel.text = UserDefaults.standard.string(forKey: "username") ?? "angelawang"
        NotificationCenter.default.addObserver(self, selector: #selector(updateSavedRecipes), name: NSNotification.Name("BookmarkUpdated"), object: nil)
    }
    
    // MARK: - Set Up Views
    
    @objc private func updateSavedRecipes() {
        savedRecipes = Recipe.loadRecipes().filter { $0.saved }
        savedRecipesCollectionView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("BookmarkUpdated"), object: nil)
    }
    
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
    
    private func setupProfilePic() {
        profilePic.image = UIImage(named: "photo")
        profilePic.contentMode = .scaleAspectFill
        profilePic.clipsToBounds = true
        
        view.addSubview(profilePic)
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profilePic.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePic.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -64),
            profilePic.widthAnchor.constraint(equalToConstant: 128),
            profilePic.heightAnchor.constraint(equalToConstant: 128)
        ])
    }
    
    private func setupNameLabel() {
        nameLabel.text = "Angela Wang"
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        nameLabel.textColor = .black
        
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profilePic.bottomAnchor, constant: 16),
            nameLabel.heightAnchor.constraint(equalToConstant: 38.19)
        ])
    }
    
    private func setupUsernameLabel() {
        usernameLabel.text = "angelawang"
        usernameLabel.font = UIFont.italicSystemFont(ofSize: 16)
        
        usernameLabel.textAlignment = .center
        usernameLabel.textColor = .black
        usernameLabel.numberOfLines = 0

        view.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupEditProfileButton() {
        // Set the settings icon
        let settingsImage = UIImage(systemName: "gearshape")?.withRenderingMode(.alwaysTemplate)
        editProfileButton.setImage(settingsImage, for: .normal)
        editProfileButton.imageView?.contentMode = .scaleAspectFit
        editProfileButton.tintColor = .black // Set icon color
        editProfileButton.clipsToBounds = true
        editProfileButton.addTarget(self, action: #selector(pushEditProfile), for: .touchUpInside)
        
//        view.addSubview(editProfileButton)
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        editProfileButton.imageEdgeInsets = UIEdgeInsets(top: -15, left: 0, bottom: 10, right: -10)
        NSLayoutConstraint.activate([
            editProfileButton.widthAnchor.constraint(equalToConstant: 30),
            editProfileButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        let barButtonItem = UIBarButtonItem(customView: editProfileButton)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    private func setupInterestsLabel() {
        interestsLabel.text = "Interests"
        interestsLabel.font = UIFont.boldSystemFont(ofSize: 16)
        interestsLabel.textColor = .black

        view.addSubview(interestsLabel)
        interestsLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            interestsLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 16),
            interestsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ])
    }
    
    private func setupInterestsCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8

        // Create a container view for the collection view
        let collectionContainer = UIView()
        collectionContainer.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        collectionContainer.layer.cornerRadius = 15 // Round corners
        collectionContainer.clipsToBounds = true // Ensure corners are clipped
        view.addSubview(collectionContainer)
        collectionContainer.translatesAutoresizingMaskIntoConstraints = false

        // Configure the collection view
        interestsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        interestsCollectionView.backgroundColor = .clear // Transparent to show container view's color
        interestsCollectionView.delegate = self
        interestsCollectionView.dataSource = self
        interestsCollectionView.register(InterestCell.self, forCellWithReuseIdentifier: InterestCell.reuseIdentifier)
        collectionContainer.addSubview(interestsCollectionView)
        interestsCollectionView.translatesAutoresizingMaskIntoConstraints = false

        // Constraints for the container view
        NSLayoutConstraint.activate([
            collectionContainer.topAnchor.constraint(equalTo: interestsLabel.bottomAnchor, constant: 8),
            collectionContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            collectionContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            collectionContainer.heightAnchor.constraint(equalToConstant: 148) // Increased height for padding
        ])

        // Constraints for the collection view inside the container view
        NSLayoutConstraint.activate([
            interestsCollectionView.topAnchor.constraint(equalTo: collectionContainer.topAnchor, constant: 10),
            interestsCollectionView.leadingAnchor.constraint(equalTo: collectionContainer.leadingAnchor, constant: 10),
            interestsCollectionView.trailingAnchor.constraint(equalTo: collectionContainer.trailingAnchor, constant: -10),
            interestsCollectionView.bottomAnchor.constraint(equalTo: collectionContainer.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupSavedRecipesLabel() {
        savedRecipesLabel.text = "Saved Recipes"
        savedRecipesLabel.font = UIFont.boldSystemFont(ofSize: 16)
        savedRecipesLabel.textColor = .black
        view.addSubview(savedRecipesLabel)
        savedRecipesLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            savedRecipesLabel.topAnchor.constraint(equalTo: interestsCollectionView.bottomAnchor, constant: 24),
            savedRecipesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ])
    }

    private func setupSavedRecipesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 0
        savedRecipesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        savedRecipesCollectionView.backgroundColor = .clear
        savedRecipesCollectionView.delegate = self
        savedRecipesCollectionView.dataSource = self
        savedRecipesCollectionView.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.reuseIdentifier)
        view.addSubview(savedRecipesCollectionView)
        savedRecipesCollectionView.translatesAutoresizingMaskIntoConstraints = false

        savedRecipesCollectionView.refreshControl = refreshControl
            refreshControl.addTarget(self, action: #selector(refreshSavedRecipes), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            savedRecipesCollectionView.topAnchor.constraint(equalTo: savedRecipesLabel.bottomAnchor, constant: 16),
            savedRecipesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            savedRecipesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            savedRecipesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func refreshSavedRecipes() {
        // Reload saved recipes from UserDefaults
        savedRecipes = Recipe.loadRecipes().filter { $0.saved }
        savedRecipesCollectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
    // MARK: - View Layout
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profilePic.layer.cornerRadius = profilePic.frame.size.width / 2
    }
    
    // MARK: - Button Helpers
    @objc private func pushEditProfile() {
        let editProfile = EditProfileVC(name: nameLabel.text!, username: usernameLabel.text!, EditProfileDelegate: self)
        navigationController?.pushViewController(editProfile, animated: true)
    }
}

// MARK: - UpdateTextDelegate

extension ProfileViewController: EditProfileDelegate {

    func didUpdateProfile(name: String, username: String) {
        usernameLabel.text = username
        nameLabel.text = name
        
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(username, forKey: "username")
    }
}

protocol EditProfileDelegate: AnyObject {
    func didUpdateProfile(name: String, username: String)
}

// MARK: - UICollectionViewDataSource for Saved Recipes
extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == interestsCollectionView {
            return interests.count
        } else if collectionView == savedRecipesCollectionView {
            return savedRecipes.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == interestsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestCell.reuseIdentifier, for: indexPath) as! InterestCell
            cell.configure(with: interests[indexPath.item])
            return cell
        } else if collectionView == savedRecipesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.reuseIdentifier, for: indexPath) as! RecipeCell
            let recipe = savedRecipes[indexPath.item]
            cell.configure(with: recipe, isBookmarked: recipe.saved)
            cell.delegate = self // Assign self as the delegate
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate for Saved Recipes
extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == savedRecipesCollectionView {
            let selectedRecipe = savedRecipes[indexPath.item]
            let detailVC = RecipeDetailViewController()
            detailVC.recipe = selectedRecipe
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

// MARK: - RecipeCellDelegate
extension ProfileViewController: RecipeCellDelegate {
    func didTapBookmark(for cell: RecipeCell) {
        guard let indexPath = savedRecipesCollectionView.indexPath(for: cell) else { return }
        var recipe = savedRecipes[indexPath.item]
        recipe.saved.toggle()
        if recipe.saved {
            savedRecipes.append(recipe)
        } else {
            savedRecipes.removeAll { $0.id == recipe.id }
        }
        Recipe.saveRecipes(savedRecipes)
        
        // Reload collection view to reflect changes
        savedRecipesCollectionView.reloadData()
        
        // Notify other parts of the app
        NotificationCenter.default.post(name: NSNotification.Name("BookmarkUpdated"), object: nil)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == interestsCollectionView {
            let text = interests[indexPath.item]
            let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)]).width + 24
            return CGSize(width: width, height: 36)
        } else if collectionView == savedRecipesCollectionView {
            let width = (UIScreen.main.bounds.width - 48) / 2
            return CGSize(width: width, height: 160)
        } else {
            return CGSize(width: 100, height: 100)
        }
    }
}
