//
//  HomeViewModel.swift
//  GamesApp
//
//  Created by Fatih on 15.07.2024.
//

import Foundation

class HomeViewModel {
    var gameService: GameService = NetworkService()
    var allGames = [GameResult]()
    
    
    func allGamesRequest(completion: @escaping (() -> Void)) {
        gameService.getAllGames { result in
            switch result {
            case .success(let games):
                self.allGames = games.results
                completion()
            case .failure(let failure):
                completion()
                print("ERROR: \(failure)")
            }
        }
    }
}
