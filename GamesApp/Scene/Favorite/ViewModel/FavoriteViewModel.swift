//
//  FavoriteViewModel.swift
//  GamesApp
//
//  Created by Fatih on 17.07.2024.
//

import Foundation

class FavoriteViewModel {
    var gameService: GameService = NetworkService()
    var gameDetails: [GameResponseDetailModel] = []
    var savedGames = [Games]()
    
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
        
        savedGames.forEach { coreDataGame in
            group.enter()
            queue.async {
                self.gameService.getDetailGame(id: Int(coreDataGame.gameID)) { result in
                    switch result {
                    case .success(let gameDetail):
                        self.gameDetails.append(gameDetail)
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
            }
        }

    }
}
