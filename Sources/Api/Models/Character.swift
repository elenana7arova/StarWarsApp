//
//  Character.swift
//  StarWarsApp
//
//  Created by Elena Nazarova on 26.08.2023.
//

import Foundation

class Character: Decodable, Identifiable {
    let name: String
    let gender: Gender?
    let starshipsPiloted: Int
    let id: String
    
    enum Gender: String {
        case male
        case female
    }
    
    enum CodingKeys: CodingKey {
        case name
        case gender
        case starships
        case url
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        let gender = try container.decode(String.self, forKey: .gender)
        self.gender = Gender(rawValue: gender)
        self.starshipsPiloted = try container.decode([String].self, forKey: .starships).count
        self.id = try container.decode(String.self, forKey: .url)
    }
    
    init(name: String, gender: Gender?, starshipsPiloted: Int, id: String) {
        self.name = name
        self.gender = gender
        self.starshipsPiloted = starshipsPiloted
        self.id = id
    }
}
