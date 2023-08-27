//
//  StarhipParsingTests.swift
//  StarWarsAppUnitTests
//
//  Created by Elena Nazarova on 27.08.2023.
//

import XCTest
@testable import StarWarsApp

final class StarhipParsingTests: XCTestCase {

    func testMilleniumFalcon() throws {
        let json = """
        {
            "name": "Millennium Falcon", 
            "model": "YT-1300 light freighter", 
            "manufacturer": "Corellian Engineering Corporation", 
            "cost_in_credits": "100000", 
            "length": "34.37", 
            "max_atmosphering_speed": "1050", 
            "crew": "4", 
            "passengers": "6", 
            "cargo_capacity": "100000", 
            "consumables": "2 months", 
            "hyperdrive_rating": "0.5", 
            "MGLT": "75", 
            "starship_class": "Light freighter", 
            "pilots": [
                "https://swapi.dev/api/people/13/", 
                "https://swapi.dev/api/people/14/", 
                "https://swapi.dev/api/people/25/", 
                "https://swapi.dev/api/people/31/"
            ], 
            "films": [
                "https://swapi.dev/api/films/1/", 
                "https://swapi.dev/api/films/2/", 
                "https://swapi.dev/api/films/3/"
            ], 
            "created": "2014-12-10T16:59:45.094000Z", 
            "edited": "2014-12-20T21:23:49.880000Z", 
            "url": "https://swapi.dev/api/starships/10/"
        }
"""
        let data = json.data(using: .utf8)!
        let starshipDecoded = try! JSONDecoder().decode(StarShip.self, from: data)
        XCTAssertEqual(starshipDecoded.name, "Millennium Falcon", "Неправильно декодировалось имя")
        XCTAssertEqual(starshipDecoded.model, "YT-1300 light freighter", "Неправильно декодировалась модель")
        XCTAssertEqual(starshipDecoded.manufacturer, "Corellian Engineering Corporation", "Неправильно декодировался производитель")
        XCTAssertEqual(starshipDecoded.passengers, "6", "Неправильно декодировались пассажиры")
    }
}
