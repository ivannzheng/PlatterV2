//
//  GroupViewController.swift
//  Platter
//
//  Created by Yuan Gao on 12/3/24.
//

import UIKit

class GroupViewController: UIViewController {
    private let header = UIView()
    private let groupsLabel = UILabel()
    private let newsFeedLabel = UILabel()
    private let titleLabel = UILabel()
    private var groupsCollectionView: UICollectionView!
    private let createPostButton = UIButton()

    // MARK: - Data
    private var groups: [String] = ["Ithaca Bakers", "Global Cuisine Explorers", "Bakers Unite"]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupHeader()
        setupTitle()
        setupGroupsCollectionView()
        setupNewsFeedLabel()
        setupCreatePostButton()
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
    
    private func setupTitle() {
        titleLabel.text = "Groups"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: -48)
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

    private func setupNewsFeedLabel() {
        newsFeedLabel.text = "News Feed"
        newsFeedLabel.font = UIFont.boldSystemFont(ofSize: 18)
        newsFeedLabel.textColor = .black
        view.addSubview(newsFeedLabel)
        newsFeedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsFeedLabel.topAnchor.constraint(equalTo: groupsCollectionView.bottomAnchor, constant: 16),
            newsFeedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ])
    }

    private func setupCreatePostButton() {
        createPostButton.setTitle("Create Post", for: .normal)
        createPostButton.setTitleColor(.black, for: .normal)
        createPostButton.setImage(UIImage(systemName: "plus"), for: .normal)
        createPostButton.tintColor = .black
        createPostButton.backgroundColor = UIColor(red: 232/255, green: 213/255, blue: 183/255, alpha: 1.0)
        createPostButton.layer.cornerRadius = 16
        createPostButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        createPostButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        createPostButton.addTarget(self, action: #selector(createPostTapped), for: .touchUpInside)
        view.addSubview(createPostButton)
        createPostButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createPostButton.topAnchor.constraint(equalTo: newsFeedLabel.bottomAnchor, constant: 12),
            createPostButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            createPostButton.widthAnchor.constraint(equalToConstant: 140),
            createPostButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    // MARK: - Actions
    @objc private func createPostTapped() {
        let createPostVC = CreatePostVC()
        navigationController?.pushViewController(createPostVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension GroupViewController: UICollectionViewDataSource {
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
extension GroupViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = groups[indexPath.item]
        let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)]).width + 32
        return CGSize(width: width, height: 40)
    }
}
