//
//  CoreDataManager.swift
//  GamesApp
//
//  Created by Fatih on 17.07.2024.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveGame(gameID: Int32) {
        let request: NSFetchRequest<Games> = Games.fetchRequest()
        request.predicate = NSPredicate(format: "gameID == %@", "\(gameID)")
        
        if let existGame = try? context.fetch(request).first {
            return
        }
        
        let games = Games(context: context)
        games.gameID = gameID
        
        do {
            try  self.context.save()
            print(gameID)
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
    }
    
    func isFavorite(gameID: Int32) -> Bool {
        if let fetchedGames = fetchGame() {
            return  fetchedGames.contains{ $0.gameID == gameID}
        }
        return false
    }
    
    
    func fetchGame() -> [Games]? {
        do {
            let fetchData = try self.context.fetch(Games.fetchRequest())
            return fetchData
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    func deleteGame(gameID: Int32) {
        let request: NSFetchRequest<Games> = Games.fetchRequest()
        request.predicate = NSPredicate(format: "gameID == %@", "\(gameID)")
        if let gameToDelete = try? context.fetch(request).first {
            context.delete(gameToDelete)
            try? context.save()
        }
    }
}
