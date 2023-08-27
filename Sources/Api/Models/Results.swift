//
//  CharacterModel.swift
//  StarWarsApp
//
//  Created by Elena Nazarova on 25.08.2023.
//

import Foundation

class Results<Element: Decodable>: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Element]
}
