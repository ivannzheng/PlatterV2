//
//  FilterCell.swift
//  Platter
//
//  Created by Yuan Gao on 12/6/24.
//

import UIKit

class FilterCell: UICollectionViewCell {
    static let reuseIdentifier = "FilterCell"

    private let filterButton = UIButton(type: .system)
    var delegate: FilterCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupFilterButton()
    }

    private func setupFilterButton() {
        contentView.addSubview(filterButton)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        filterButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        filterButton.layer.cornerRadius = 16
        filterButton.layer.masksToBounds = true
        
        filterButton.backgroundColor = UIColor(red: 232/255, green: 213/255, blue: 183/255, alpha: 1.0)
        filterButton.titleLabel?.textAlignment = .center
        filterButton.titleLabel?.numberOfLines = 1

        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            filterButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            filterButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            filterButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
    }
    
    @objc private func filterButtonTapped() {
        guard let title = filterButton.title(for: .normal) else { return }
        delegate?.didTapFilterButton(title: title)
    }

    func configure(with title: String, isSelected: Bool) {
        filterButton.setTitle(title, for: .normal)
        filterButton.setTitleColor(isSelected ? .white : .black, for: .normal)
        filterButton.backgroundColor = isSelected
            ? UIColor(red: 140/255, green: 108/255, blue: 58/255, alpha: 1.0) // Selected color
            : UIColor(red: 232/255, green: 213/255, blue: 183/255, alpha: 1.0) // Default color
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol FilterCellDelegate: AnyObject {
    func didTapFilterButton(title: String)
}
