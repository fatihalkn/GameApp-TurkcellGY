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
    var gameMovie = [String]()
    var gameID: Int?
    var indexPath: IndexPath?
    
    func detailGamesRequest(completion: @escaping (() -> Void)) {
        guard let gameID = self.gameID else { return }
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
    
    func getGameMoviesRequest(completion: @escaping (() -> Void)) {
        guard let gameID = self.gameID else { return }
        gameService.getGameMovies(id: gameID) { movieResult in
            switch movieResult {
            case .success(let movie):
                self.gameMovie = movie.results.map { $0.data.the480 }
                completion()
            case .failure(let failure):
                completion()
                print("ERROR: \(failure)")
            }
        }
    }
}
