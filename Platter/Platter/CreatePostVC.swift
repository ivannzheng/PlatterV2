//
//  CreatePostVC.swift
//  Platter
//
//  Created by Yuan Gao on 12/5/24.
//

import UIKit

class CreatePostVC: UIViewController {
    private let header = UIView()
    private let groupsLabel = UILabel()
    private let titleLabel = UILabel()
    private let backButton = UIButton()
    private var groupsCollectionView: UICollectionView!
    private let createPostLabel = UILabel()
    private let postTitleField = UITextField()
    private let captionTextView = UITextView()
    private let postButton = UIButton()


    
    // MARK: - Data
    private var groups: [String] = ["Ithaca Bakers", "Global Cuisine Explorers", "Bakers Unite"]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupHeader()
        setupBackButton()
        setupTitle()
        setupGroupsCollectionView()
        setupCreatePostLabel()
        setupPostTitleField()
        setupCaptionField()
        setupPostButton()
        
    }
    
    // MARK: - Setup Views
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
    
    private func setupBackButton() {
        backButton.setImage(UIImage(named: "arrow"), for: .normal)
        backButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        backButton.clipsToBounds = true
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 12),
            backButton.heightAnchor.constraint(equalToConstant: 24),
        ])

        let barButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = barButton
    }
    
    @objc private func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupTitle() {
        titleLabel.text = "Groups"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: -32)
        ])
    }
    
    private func setupGroupsCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        
        groupsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        groupsCollectionView.backgroundColor = .clear
        groupsCollectionView.showsHorizontalScrollIndicator = false
        groupsCollectionView.delegate = self
        groupsCollectionView.dataSource = self
        groupsCollectionView.register(GroupCell.self, forCellWithReuseIdentifier: GroupCell.reuseIdentifier)
        groupsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        view.addSubview(groupsCollectionView)
        groupsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            groupsCollectionView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 16),
            groupsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            groupsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            groupsCollectionView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupCreatePostLabel() {
        createPostLabel.text = "Create Post"
        createPostLabel.font = UIFont.boldSystemFont(ofSize: 16)
        createPostLabel.textColor = .black
        view.addSubview(createPostLabel)
        createPostLabel.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            createPostLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            createPostLabel.topAnchor.constraint(equalTo: groupsCollectionView.bottomAnchor, constant: 24)
        ])
    }
    
    private func setupPostTitleField() {
        let postTitleLabel = UILabel()
        postTitleLabel.text = "Title"
        postTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        postTitleLabel.textColor = .black
        view.addSubview(postTitleLabel)
        postTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        postTitleField.placeholder = "Title..."
        postTitleField.borderStyle = .roundedRect
        postTitleField.font = UIFont.systemFont(ofSize: 16)
        postTitleField.layer.borderWidth = 1
        postTitleField.layer.borderColor = .none
        
        postTitleField.layer.cornerRadius = 15
        view.addSubview(postTitleField)
        postTitleField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            postTitleLabel.topAnchor.constraint(equalTo: createPostLabel.bottomAnchor, constant: 16),
            postTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            postTitleField.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: 8),
            postTitleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            postTitleField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            postTitleField.heightAnchor.constraint(equalToConstant: 42)
        ])
    }

    private func setupCaptionField() {
        captionTextView.text = "Write a caption..."
        captionTextView.font = UIFont.systemFont(ofSize: 16)
        captionTextView.textColor = .lightGray
        captionTextView.layer.cornerRadius = 15
        captionTextView.layer.borderWidth = 1
        captionTextView.layer.borderColor = UIColor.black.cgColor

        captionTextView.isScrollEnabled = true
        captionTextView.delegate = self
        
        view.addSubview(captionTextView)
        captionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            captionTextView.topAnchor.constraint(equalTo: postTitleField.bottomAnchor, constant: 24),
            captionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            captionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            captionTextView.heightAnchor.constraint(equalToConstant: 176)
        ])
    }
    
    private func setupPostButton() {
        postButton.setTitle("Post", for: .normal)
        postButton.backgroundColor = UIColor(red: 232/255, green: 213/255, blue: 183/255, alpha: 1.0)
        postButton.setTitleColor(.black, for: .normal)
        postButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        postButton.layer.cornerRadius = 15
        postButton.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
        view.addSubview(postButton)
        postButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            postButton.topAnchor.constraint(equalTo: captionTextView.bottomAnchor, constant: 24),
            postButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postButton.widthAnchor.constraint(equalTo: captionTextView.widthAnchor),
            postButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func postButtonTapped() {
        print("Post button tapped")
    }
}

// MARK: - UICollectionViewDataSource
extension CreatePostVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupCell.reuseIdentifier, for: indexPath) as! GroupCell
        cell.configure(with: groups[indexPath.item])
        if indexPath.item == 0 {
            cell.contentView.backgroundColor = UIColor(red: 140/255, green: 108/255, blue: 58/255, alpha: 1.0)
            cell.titleLabel.textColor = .white
        } else {
            cell.contentView.backgroundColor = UIColor(red: 232/255, green: 213/255, blue: 183/255, alpha: 1.0)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CreatePostVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = groups[indexPath.item]
        let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)]).width + 32
        return CGSize(width: width, height: 40)
    }
}

extension CreatePostVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == captionTextView && textView.text == "Write a caption..." {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == captionTextView && textView.text.isEmpty {
            textView.text = "Write a caption..."
            textView.textColor = .lightGray 
        }
    }
}
