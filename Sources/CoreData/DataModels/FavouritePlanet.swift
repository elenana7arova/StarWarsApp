//
//  FavouritePlanet+CoreDataClass.swift
//  StarWarsApp
//
//  Created by Elena Nazarova on 26.08.2023.
//

import Foundation
import CoreData

@objc(FavouritePlanet)
public class FavouritePlanet: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouritePlanet> {
        return NSFetchRequest<FavouritePlanet>(entityName: "FavouritePlanet")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var diameter: String
    @NSManaged public var population: String
}
