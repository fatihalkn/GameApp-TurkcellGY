//
//  NetworkEndPointHelper.swift
//  GamesApp
//
//  Created by Fatih on 15.07.2024.
//

import Foundation

struct NetworkEndPointHelper {
    static let shared = NetworkEndPointHelper()
    let APIKey = "?key=fb2ccfde64f24fc4858c59556f42a9ca"
    
    
    func requestAllGames(APIkey: String) -> String {
        NetworkConstants.baseURL  + APIkey
    }
    
    func requestGameDetail(id: Int) -> String {
        NetworkConstants.baseURL + "/\(id)" + APIKey
    }
    
    func requestGameScreenShoots(id: Int) -> String {
        NetworkConstants.baseURL + "/\(id)" + "/screenshots" + APIKey
    }
    
    func requestGameMovies(id: Int) -> String {
        NetworkConstants.baseURL + "/\(id)" + "/movies" + APIKey
    }
    
    func requestGameDevelopmentTeam(id: String) -> String {
        NetworkConstants.baseURL + "/\(id)" + "/development-team" + APIKey
    }
    
    
}
