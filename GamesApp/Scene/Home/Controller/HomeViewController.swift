//
//  HomeViewController.swift
//  GamesApp
//
//  Created by Fatih on 15.07.2024.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Properties
    let homeView = HomeView()
    let homeViewModel = HomeViewModel()
    
    
    //MARK: - Lyfe Circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        allGamesRequest()
        setupRegister()
        setupDelegate()
        
    }
    
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    func setupRegister() {
        homeView.homeCollectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        
        homeView.homeCollectionView.register(HomeViewCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeViewCollectionViewHeader.identifier)
    }
    
    func setupDelegate() {
        homeView.homeCollectionView.dataSource = self
        homeView.homeCollectionView.delegate = self
    }
    
    func allGamesRequest() {
        homeViewModel.allGamesRequest {
            self.homeView.homeCollectionView.reloadData()
        }
    }
}

//MARK: -  SearchBar Configure
extension HomeViewController: UISearchResultsUpdating  {
    func setupSearchController() {
        self.homeView.searchBar.searchResultsUpdater = self
        self.navigationItem.searchController = homeView.searchBar
        self.definesPresentationContext = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
}


//MARK: - Configure CollectionView
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.allGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        let model = homeViewModel.allGames[indexPath.item]
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
        let gameID = homeViewModel.allGames[indexPath.item].id
        vc.gameDetailViewModel.gameID = gameID
        print(gameID)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Configure CollectionViewHeader
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeViewCollectionViewHeader.identifier, for: indexPath) as! HomeViewCollectionViewHeader
              return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height / 4 )
    }
    
    
  }
        

