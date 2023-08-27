//
//  FavouriteStarship+CoreDataClass.swift
//  StarWarsApp
//
//  Created by Elena Nazarova on 26.08.2023.
//

import Foundation
import CoreData

@objc(FavouriteStarship)
public class FavouriteStarship: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteStarship> {
        return NSFetchRequest<FavouriteStarship>(entityName: "FavouriteStarship")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var model: String
    @NSManaged public var manufacturer: String
    @NSManaged public var passengers: String
}
