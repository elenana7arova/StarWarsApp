//
//  FavouriteCharacter.swift
//  StarWarsApp
//
//  Created by Elena Nazarova on 25.08.2023.
//

import Foundation
import CoreData

@objc(FavouriteCharacter)
public class FavouriteCharacter: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteCharacter> {
        return NSFetchRequest<FavouriteCharacter>(entityName: "FavouriteCharacter")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var gender: String
    @NSManaged public var shipsPiloted: Int
}
