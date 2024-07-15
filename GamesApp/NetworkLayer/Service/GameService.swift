//
//  GameService.swift
//  GamesApp
//
//  Created by Fatih on 15.07.2024.
//

import Foundation

protocol GameService {
    func getAllGames(completion: @escaping (Result<GamesResponseModel, Error>) -> Void)
}

extension NetworkService: GameService {
    func getAllGames(completion: @escaping (Result<GamesResponseModel, Error>) -> Void) {
        NetworkManager.shared.request(url: NetworkConstants.baseURL + NetworkEndPointHelper.shared.APIKey, method: .get, completion: completion)
    }
    
    
}
