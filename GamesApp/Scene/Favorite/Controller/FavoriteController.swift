//
//  FavoriteController.swift
//  GamesApp
//
//  Created by Fatih on 17.07.2024.
//

import Foundation
import UIKit

class FavoriteController: UIViewController {
    
    //MARK: - Properties
    let favoriteView = FavoriteView()
    let favoriteViewModel = FavoriteViewModel()
    
    //MARK: - Lyfe Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupRegister()
        setupSearchController()
        
    }
    
    override func loadView() {
         super.loadView()
        view = favoriteView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataGames()
        requestFavoriteGames()
        self.upDateEmptyLabelVisibility()

    }
    
    
    func setupRegister() {
        favoriteView.favoriteCollectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifier)
    }
    
    func setupDelegate() {
        favoriteView.favoriteCollectionView.dataSource = self
        favoriteView.favoriteCollectionView.delegate = self
    }
    
    func fetchCoreDataGames() {
        favoriteViewModel.fetchGames()
        upDateEmptyLabelVisibility()
    }
    
    func requestFavoriteGames() {
        favoriteViewModel.favoriteGamesRequest {
            self.favoriteView.favoriteCollectionView.reloadData()
            self.upDateEmptyLabelVisibility()

        }
    }
    
    func upDateEmptyLabelVisibility() {
        if favoriteViewModel.gameDetails.isEmpty {
            favoriteView.showEmptyLabel()
        } else {
            favoriteView.hiddenEmptyLabel()
        }
    }
}

//MARK: -  SearchBar Configure
extension FavoriteController: UISearchResultsUpdating  {
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
    
    func setupSearchController() {
        self.favoriteView.searchBar.searchResultsUpdater = self
        self.navigationItem.searchController = favoriteView.searchBar
        self.definesPresentationContext = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

//MARK: - Configure CollectionView

extension FavoriteController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteViewModel.gameDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as! FavoriteCollectionViewCell
        let model = favoriteViewModel.gameDetails[indexPath.item]
        cell.configure(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight: CGFloat = collectionView.frame.height / 6
        let cellWidth: CGFloat = (collectionView.frame.width) - 30
        return.init(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = GameDetailViewController()
        let gameID = favoriteViewModel.gameDetails[indexPath.item].id
        vc.gameDetailViewModel.gameID = gameID
        vc.gameDetailViewModel.indePath = indexPath
        print(gameID)
        navigationController?.pushViewController(vc, animated: true)
    }
}
