//
//  GameMoviesResponseModel.swift
//  GamesApp
//
//  Created by Fatih on 18.07.2024.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let gameMoviesResponseModel = try? JSONDecoder().decode(GameMoviesResponseModel.self, from: jsonData)

import Foundation

// MARK: - GameMoviesResponseModel
struct GameMoviesResponseModel: Codable {
    let count: Int
    let next, previous: JSONNull?
    let results: [MovieResult]
}

// MARK: - Result
struct MovieResult: Codable {
    let id: Int
    let name: String
    let preview: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let the480, max: String

    enum CodingKeys: String, CodingKey {
        case the480 = "480"
        case max
    }
}


