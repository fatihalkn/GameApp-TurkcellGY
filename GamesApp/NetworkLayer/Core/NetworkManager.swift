//
//  NetworkManager.swift
//  GamesApp
//
//  Created by Fatih on 15.07.2024.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
}

//MARK: - Request Method
extension NetworkManager {
    func request<T: Codable>(url:String, method: HTTPMethod, completion: @escaping(Result<T, Error>) -> Void) {
        AF.request(URL(string: url)!, method: method).validate().responseDecodable(of: T.self) { response in
            let result = response.result
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}

