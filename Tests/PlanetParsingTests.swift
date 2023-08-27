//
//  PlanetParsingTests.swift
//  StarWarsAppUnitTests
//
//  Created by Elena Nazarova on 27.08.2023.
//

import XCTest
@testable import StarWarsApp

final class PlanetParsingTests: XCTestCase {
    
    func testHoth() throws {
        let json = """
        {
            "name": "Hoth", 
            "rotation_period": "23", 
            "orbital_period": "549", 
            "diameter": "7200", 
            "climate": "frozen", 
            "gravity": "1.1 standard", 
            "terrain": "tundra, ice caves, mountain ranges", 
            "surface_water": "100", 
            "population": "unknown", 
            "residents": [], 
            "films": [
                "https://swapi.dev/api/films/2/"
            ], 
            "created": "2014-12-10T11:39:13.934000Z", 
            "edited": "2014-12-20T20:58:18.423000Z", 
            "url": "https://swapi.dev/api/planets/4/"
        }
"""
        let data = json.data(using: .utf8)!
        let planetDecoded = try! JSONDecoder().decode(Planet.self, from: data)
        XCTAssertEqual(planetDecoded.name, "Hoth", "Неправильно декодировалось имя")
        XCTAssertEqual(planetDecoded.diameter, "7200", "Неправильно декодировался диаметр")
        XCTAssertEqual(planetDecoded.population, "unknown", "Неправильно декодировалась популяция")
    }

}
