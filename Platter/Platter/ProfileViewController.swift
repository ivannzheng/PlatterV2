//
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
    
    // MARK: - Properties (data)
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupHeader()
        setupProfilePic()
        setupNameLabel()
        setupUsernameLabel()
        setupEditProfileButton()
        
        nameLabel.text = UserDefaults.standard.string(forKey: "name") ?? "Angela Wang"
        usernameLabel.text = UserDefaults.standard.string(forKey: "username") ?? "angelawang"
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
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupEditProfileButton() {
        editProfileButton.setTitle("Edit Profile", for: .normal)
        editProfileButton.backgroundColor = UIColor(red: 232/255, green: 213/255, blue: 183/255, alpha: 1.0)
        editProfileButton.setTitleColor(.black, for: .normal)
        editProfileButton.layer.cornerRadius = 16
        editProfileButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        editProfileButton.contentHorizontalAlignment = .center
        editProfileButton.addTarget(self, action: #selector(pushEditProfile), for: .touchUpInside)
        
        view.addSubview(editProfileButton)
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            editProfileButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            editProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            editProfileButton.widthAnchor.constraint(equalToConstant: 95),
            editProfileButton.heightAnchor.constraint(equalToConstant: 40)
        ])
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

