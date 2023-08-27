//
//  Planet.swift
//  StarWarsApp
//
//  Created by Elena Nazarova on 26.08.2023.
//

import Foundation

class Planet: Decodable, Identifiable {
    let name: String
    let diameter: String
    let population: String
    let id: String
    
    enum CodingKeys: CodingKey {
        case name
        case diameter
        case population
        case url
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.diameter = try container.decode(String.self, forKey: .diameter)
        self.population = try container.decode(String.self, forKey: .population)
        self.id = try container.decode(String.self, forKey: .url)
    }
    
    init(name: String, diameter: String, population: String, id: String) {
        self.name = name
        self.diameter = diameter
        self.population = population
        self.id = id
    }
}
