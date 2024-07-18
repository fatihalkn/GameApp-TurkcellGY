//
//  HomeView.swift
//  GamesApp
//
//  Created by Fatih on 15.07.2024.
//

import Foundation
import UIKit

class HomeView: UIView {
    
    
    
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
    
    let homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
}

//MARK: - SetupUI
extension HomeView {
    func setupUI() {
        addSubview(homeCollectionView)
        
        NSLayoutConstraint.activate([
            homeCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            homeCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            homeCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -15)
        ])
    }
}
