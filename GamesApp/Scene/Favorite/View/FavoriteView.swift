//
//  FavoriteView.swift
//  GamesApp
//
//  Created by Fatih on 17.07.2024.
//

import Foundation
import UIKit

class FavoriteView: UIView {
    
    
    //MARK: - İnit Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradient(colors: [.gradiantCL1,.gradiantCL1,.gradiantCL2], startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1.0))
    }
    
    //MARK: - UI Elements
    let searchBar: UISearchController = {
        let searchBar = UISearchController(searchResultsController: nil)
        searchBar.obscuresBackgroundDuringPresentation = false
        searchBar.hidesNavigationBarDuringPresentation = true
        searchBar.searchBar.barTintColor = .clear
        searchBar.searchBar.backgroundColor = .clear
        searchBar.searchBar.backgroundImage = UIImage()
        searchBar.searchBar.placeholder = "Search Games"
        searchBar.searchBar.barStyle = .black
        return searchBar
    }()
    
    let favoriteCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Your favorites list is empty."
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .tabCL1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emptyImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = .favoriteEmpty
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let emptyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    func showEmptyLabel() {
        favoriteCollectionView.addSubview(emptyStackView)
        NSLayoutConstraint.activate([
            emptyStackView.centerYAnchor.constraint(equalTo: favoriteCollectionView.centerYAnchor),
            emptyStackView.centerXAnchor.constraint(equalTo: favoriteCollectionView.centerXAnchor),
            emptyStackView.heightAnchor.constraint(equalToConstant: 100),
            emptyStackView.widthAnchor.constraint(equalTo: favoriteCollectionView.widthAnchor, multiplier: 0.8)
        ])
        emptyStackView.isHidden = false
    }
    
    func hiddenEmptyLabel() {
        emptyStackView.removeFromSuperview()
        emptyStackView.isHidden = true
    }
}

//MARK: - SetupUI
extension FavoriteView {
    func setupUI() {
        addSubview(favoriteCollectionView)
        emptyStackView.addArrangedSubview(emptyImageView)
        emptyStackView.addArrangedSubview(emptyLabel)
        
        NSLayoutConstraint.activate([
            favoriteCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            favoriteCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            favoriteCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            favoriteCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            
        ])
    }
}


