//
//  Games+CoreDataProperties.swift
//  GamesApp
//
//  Created by Fatih on 17.07.2024.
//
//

import Foundation
import CoreData


extension Games {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Games> {
        return NSFetchRequest<Games>(entityName: "Games")
    }

    @NSManaged public var gameID: Int32

}

extension Games : Identifiable {

}
