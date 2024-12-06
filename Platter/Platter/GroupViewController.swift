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
    private var postsCollectionView: UICollectionView!
    private var posts: [Post] = Post.dummyPosts
    private let logoImageView = UIImageView()

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
        setupPostsCollectionView()
        setupLogo()
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
        titleLabel.text = "Groups"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: -40)
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
    
    private func setupPostsCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 60

        postsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        postsCollectionView.backgroundColor = .clear
        postsCollectionView.delegate = self
        postsCollectionView.dataSource = self
        postsCollectionView.register(PostCell.self, forCellWithReuseIdentifier: PostCell.reuseIdentifier)
        view.addSubview(postsCollectionView)
        postsCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            postsCollectionView.topAnchor.constraint(equalTo: createPostButton.bottomAnchor, constant: 16),
            postsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension GroupViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == postsCollectionView {
            return 1 // Posts collection view only has one section
        } else if collectionView == groupsCollectionView {
            return 1 // Groups collection view only has one section
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == groupsCollectionView {
            return groups.count // Number of groups
        } else if collectionView == postsCollectionView {
            return posts.count // Number of posts
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == groupsCollectionView {
            // Configure GroupCell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupCell.reuseIdentifier, for: indexPath) as! GroupCell
            cell.configure(with: groups[indexPath.item])
            if indexPath.item == 0 {
                cell.contentView.backgroundColor = UIColor(red: 140/255, green: 108/255, blue: 58/255, alpha: 1.0)
                cell.titleLabel.textColor = .white
            } else {
                cell.contentView.backgroundColor = UIColor(red: 232/255, green: 213/255, blue: 183/255, alpha: 1.0)
                cell.titleLabel.textColor = .black
            }
            return cell
        } else if collectionView == postsCollectionView {
            // Configure PostCell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.reuseIdentifier, for: indexPath) as! PostCell
            let post = posts[indexPath.item]
            cell.configure(with: post)
            return cell
        }
        fatalError("Unexpected collection view")
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GroupViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == groupsCollectionView {
            // Group collection view sizing
            let text = groups[indexPath.item]
            let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)]).width + 32
            return CGSize(width: width, height: 40)
        } else if collectionView == postsCollectionView {
            // Post collection view sizing
            let padding: CGFloat = 32 // Left and right padding
            let width = collectionView.frame.width - padding
            return CGSize(width: width, height: 160) // Example post size
        }
        return .zero
    }
}
