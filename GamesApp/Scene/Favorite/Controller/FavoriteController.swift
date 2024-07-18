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
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    override func loadView() {
         super.loadView()
        view = favoriteView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataGames()
        requestFavoriteGames()
    }
  
    
    func setupRegister() {
        favoriteView.favoriteCollectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifier)
    }
    
    func setupDelegate() {
        favoriteView.favoriteCollectionView.dataSource = self
        favoriteView.favoriteCollectionView.delegate = self
        
        favoriteViewModel.favoriteViewModelDelegate = self
    }
    
    func fetchCoreDataGames() {
        favoriteViewModel.fetchGames()
    }
    
    func requestFavoriteGames() {
        favoriteViewModel.favoriteGamesRequest {
            self.upDateEmptyLabelVisibility()
            self.favoriteView.favoriteCollectionView.reloadData()
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
        self.favoriteViewModel.updateSearchController(searchBarText: searchController.searchBar.text)
        self.favoriteView.favoriteCollectionView.reloadData()
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
        let inSearchMode = self.favoriteViewModel.inSearchModel(favoriteView.searchBar)
        return inSearchMode ? self.favoriteViewModel.filterGames.count : self.favoriteViewModel.gameDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as! FavoriteCollectionViewCell
        let inSearchMode = self.favoriteViewModel.inSearchModel(favoriteView.searchBar)
        let model = inSearchMode ? self.favoriteViewModel.filterGames[indexPath.item] : self.favoriteViewModel.gameDetails[indexPath.item]
        cell.favoriteCollectionViewCellDelegate = self
        cell.indexPath = indexPath
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
        vc.gameDetailViewModel.indexPath = indexPath
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - FavoriteCollectionViewCellProtocol
extension FavoriteController: FavoriteCollectionViewCellProtocol {
    func didTappedDeleteButton(indexPath: IndexPath) {
        let gameID = favoriteViewModel.gameDetails[indexPath.item].id
        CoreDataManager.shared.deleteGame(gameID: Int32(gameID))
        favoriteViewModel.gameDetails.remove(at: indexPath.item)
        favoriteView.favoriteCollectionView.reloadData()

    }
    
    func didTappedİnfoButton(indexPath: IndexPath) {
        let vc = GameDetailViewController()
        let gameID = favoriteViewModel.gameDetails[indexPath.item].id
        vc.gameDetailViewModel.gameID = gameID
        vc.gameDetailViewModel.indexPath = indexPath
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
  
    
    
}


//MARK: - FavoriteViewModelProtocl
extension FavoriteController: FavoriteViewModelProtocol {
    func showLoading() {
        favoriteView.showLoading(text: nil, interaction: false)
    }
    
    func removeLoading() {
        favoriteView.removeLoading()
    }
    
    
}
