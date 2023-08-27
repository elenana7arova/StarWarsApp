//
//  StarShip.swift
//  StarWarsApp
//
//  Created by Elena Nazarova on 26.08.2023.
//

import Foundation

class StarShip: Decodable, Identifiable {
    let name: String
    let model: String
    let manufacturer: String
    let passengers: String
    let id: String
    
    enum CodingKeys: CodingKey {
        case name
        case model
        case manufacturer
        case passengers
        case url
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.model = try container.decode(String.self, forKey: .model)
        self.manufacturer = try container.decode(String.self, forKey: .manufacturer)
        self.passengers = try container.decode(String.self, forKey: .passengers)
        self.id = try container.decode(String.self, forKey: .url)
    }
    
    init(name: String, model: String, manufacturer: String, passengers: String, id: String) {
        self.name = name
        self.model = model
        self.manufacturer = manufacturer
        self.passengers = passengers
        self.id = id
    }
}
