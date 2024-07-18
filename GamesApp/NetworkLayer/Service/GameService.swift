//
//  GameService.swift
//  GamesApp
//
//  Created by Fatih on 15.07.2024.
//

import Foundation

protocol GameService {
    func getAllGame(completion: @escaping (Result<GamesResponseModel, Error>) -> Void)
    func getDetailGame(id: Int,completion: @escaping (Result<GameResponseDetailModel, Error>) -> Void)
    func getGameMovies(id: Int,completion: @escaping (Result<GameMoviesResponseModel, Error>) -> Void)
}

extension NetworkService: GameService {
    func getGameMovies(id: Int, completion: @escaping (Result<GameMoviesResponseModel, Error>) -> Void) {
        NetworkManager.shared.request(url: NetworkEndPointHelper.shared.requestGameMovies(id: id), method: .get, completion: completion)
    }
    
    func getDetailGame(id: Int, completion: @escaping (Result<GameResponseDetailModel, Error>) -> Void) {
        NetworkManager.shared.request(url: NetworkEndPointHelper.shared.requestGameDetail(id: id), method: .get, completion: completion)
    }
    
    func getAllGame(completion: @escaping (Result<GamesResponseModel, Error>) -> Void) {
        NetworkManager.shared.request(url: NetworkEndPointHelper.shared.requestAllGames(APIkey: NetworkEndPointHelper.shared.APIKey), method: .get, completion: completion)
    }
    
    
}
