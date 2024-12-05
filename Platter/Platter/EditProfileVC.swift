//
//  EditProfileVC.swift
//  Platter
//
//  Created by Yuan Gao on 12/4/24.
//

import UIKit

class EditProfileVC: UIViewController {
    
    // MARK: - Properties (view)
    private let profilePic = UIImageView()
    private let nameLabel = UILabel()
    private let usernameLabel = UILabel()
    private let nameTextField = UITextField()
    private let usernameTextField = UITextField()
    private let saveButton = UIButton()
    private let editPicButton = UIButton()
    private let backButton = UIButton()
    private let header = UIView()
    
    // MARK: - Properties (data)
    
    private var name: String
    private var username: String
    private weak var profileDelegate: EditProfileDelegate?
    
    // MARK: - viewDidLoad and init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Edit Profile"
        
        setupHeader()
        setupProfilePic()
        setupNameLabel()
        setupUsernameLabel()
        setupEditName()
        setupEditUsername()
        setupSaveButton()
        setupBackButton()
        setupEditPicButton()
    }
    
    init(name: String, username: String, EditProfileDelegate: EditProfileDelegate) {
        self.name = name
        self.username = username
        self.profileDelegate = EditProfileDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            profilePic.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            profilePic.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profilePic.widthAnchor.constraint(equalToConstant: 96),
            profilePic.heightAnchor.constraint(equalToConstant: 96)
        ])
    }
    
    private func setupNameLabel() {
        nameLabel.text = name
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        nameLabel.textColor = .black

        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: profilePic.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 42)
        ])
    }
    
    private func setupUsernameLabel() {
        usernameLabel.text = username
        usernameLabel.font = UIFont.italicSystemFont(ofSize: 14)
        usernameLabel.textColor = .black
        usernameLabel.numberOfLines = 0

        view.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            usernameLabel.leadingAnchor.constraint(equalTo: profilePic.trailingAnchor, constant: 16),
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }

    private func setupEditName() {
        nameTextField.placeholder = "New Name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.textColor = .black
        nameTextField.font = UIFont.systemFont(ofSize: 14)
        nameTextField.layer.cornerRadius = 8
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.borderColor = .none
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: nameTextField.frame.height))
        nameTextField.leftView = paddingView
        nameTextField.leftViewMode = .always

        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            nameTextField.topAnchor.constraint(equalTo: profilePic.bottomAnchor, constant: 32),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            nameTextField.widthAnchor.constraint(equalToConstant: 329)
        ])
    }

    func setupEditUsername() {
        usernameTextField.placeholder = "New Username"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.textColor = .black
        usernameTextField.font = UIFont.systemFont(ofSize: 14)
        usernameTextField.layer.cornerRadius = 8
        usernameTextField.layer.borderWidth = 1
        usernameTextField.layer.borderColor = .none
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: usernameTextField.frame.height))
        usernameTextField.leftView = paddingView
        usernameTextField.leftViewMode = .always

        view.addSubview(usernameTextField)

        usernameTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 32),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            usernameTextField.widthAnchor.constraint(equalToConstant: 329)
        ])
    }

    func setupSaveButton() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = UIColor(red: 232/255, green: 213/255, blue: 183/255, alpha: 1.0)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.layer.cornerRadius = 16
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        saveButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        saveButton.contentHorizontalAlignment = .center
        saveButton.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 329),
            saveButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    func setupBackButton() {
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = UIColor.black
        backButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)

        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 12),
            backButton.heightAnchor.constraint(equalToConstant: 19)
        ])

        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 24
        let barButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItems = [spacer, barButton]
    }
    
    func setupEditPicButton() {
        editPicButton.setImage(UIImage(named: "cam"), for: .normal)
        editPicButton.tintColor = UIColor(red: 232/255, green: 213/255, blue: 183/255, alpha: 1.0)
        view.addSubview(editPicButton)
        editPicButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            editPicButton.widthAnchor.constraint(equalToConstant: 24),
            editPicButton.heightAnchor.constraint(equalToConstant: 24),
            editPicButton.trailingAnchor.constraint(equalTo: profilePic.trailingAnchor),
            editPicButton.bottomAnchor.constraint(equalTo: profilePic.bottomAnchor)
        ])
   }
    
    // MARK: - View Layout
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profilePic.layer.cornerRadius = profilePic.frame.size.width / 2
        editPicButton.layoutIfNeeded()
    }
    
    // MARK: - Button Helpers
    
    @objc private func saveChanges() {
        let name = nameTextField.text ?? name // Use the current value if text is empty
        let username = usernameTextField.text ?? username // Use the current value if text is empty
        
        // Pass updated values to delegate
        profileDelegate?.didUpdateProfile(name: name, username: username)
        
        // Save directly to UserDefaults in case delegate isn't called immediately
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(username, forKey: "username")
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func popVC() {
        navigationController?.popViewController(animated: true)
    }
}
