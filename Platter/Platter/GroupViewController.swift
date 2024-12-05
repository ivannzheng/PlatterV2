//
//  GroupViewController.swift
//  Platter
//
//  Created by Yuan Gao on 12/3/24.
//

import UIKit

class GroupViewController: UIViewController {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Groups"
        
        setupLabel()
    }
    
    private func setupLabel() {
        let label = UILabel()
        label.text = "Welcome to Groups!"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
