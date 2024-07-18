//
//  FavoriteViewModel.swift
//  GamesApp
//
//  Created by Fatih on 17.07.2024.
//

import Foundation
import UIKit
protocol FavoriteViewModelProtocol {
    func showLoading()
    func removeLoading()
}

class FavoriteViewModel {
    var gameService: GameService = NetworkService()
    var gameDetails: [GameResponseDetailModel] = []
    var filterGames: [GameResponseDetailModel] = []
    var savedGames = [Games]()
    var favoriteViewModelDelegate: FavoriteViewModelProtocol?
    
    func fetchGames() {
        guard let games = CoreDataManager.shared.fetchGame() else { return }
        self.savedGames = games
    }
    
    func checkSavedGames() {
    }
    
    func favoriteGamesRequest(completion: @escaping (() -> Void)) {
        gameDetails.removeAll()
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "favoriteGamesReqeust_", qos: .background, attributes: .concurrent)
        self.favoriteViewModelDelegate?.showLoading()
        savedGames.forEach { coreDataGame in
            group.enter()
            queue.async {
                self.gameService.getDetailGame(id: Int(coreDataGame.gameID)) { result in
                    switch result {
                    case .success(let gameDetail):
                        self.gameDetails.append(gameDetail)
                        self.filterGames.append(gameDetail)
                        group.leave()
                    case .failure(let failure):
                        print("\(coreDataGame.gameID) Error: \(failure.localizedDescription)")
                        group.leave()
                    }
                }
            }
        }
        
        group.notify(queue: queue) {
            DispatchQueue.main.async {
                completion()
                self.favoriteViewModelDelegate?.removeLoading()
            }
            
        }

    }
    
    //MARK: - Search Configure
    public func inSearchModel(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        return isActive && !searchText.isEmpty
    }
    
    public func updateSearchController(searchBarText: String?) {
        guard let searchText = searchBarText?.lowercased(), !searchText.isEmpty else {
            self.filterGames = self.gameDetails
            return
        }
        
        self.filterGames = self.gameDetails.filter { $0.name.lowercased().contains(searchText)}
    }
}
