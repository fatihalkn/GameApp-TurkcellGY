//
//  GameDetailViewModel.swift
//  GamesApp
//
//  Created by Fatih on 16.07.2024.
//

import Foundation

class GameDetailViewModel {
    var gameService: GameService = NetworkService()
    var gameDetail: GameResponseDetailModel?
    var gameID: Int?
    
    func detailGamesRequest(completion: @escaping (() -> Void)) {
        guard let gameID = self.gameID else { return}
        gameService.getDetailGame(id: gameID) { result in
            switch result {
            case .success(let gameDetail):
                self.gameDetail = gameDetail
                completion()
            case .failure(let failure):
                completion()
                print("ERROR: \(failure)")
            }
        }
    }
}
