//
//  HomeViewModel.swift
//  GamesApp
//
//  Created by Fatih on 15.07.2024.
//

import Foundation
import UIKit

class HomeViewModel {
    var gameService: GameService = NetworkService()
    var allGames = [GameResult]()
    var filterAllGames = [GameResult]()
    
    
    func allGamesRequest(completion: @escaping (() -> Void)) {
        gameService.getAllGame { result in
            switch result {
            case .success(let games):
                self.allGames = games.results
                self.filterAllGames = games.results
                completion()
            case .failure(let failure):
                completion()
                print("ERROR: \(failure)")
            }
        }
    }
    
    //MARK: - Search Func
    public func inSearchModel(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        return isActive && !searchText.isEmpty
    }
    
    public func updateSearchController(searchBarText: String?) {
        guard let searchText = searchBarText?.lowercased(), !searchText.isEmpty else {
            self.filterAllGames = self.allGames
            return
        }
        
        self.filterAllGames = self.allGames.filter { $0.name.lowercased().contains(searchText)}
    }
}
