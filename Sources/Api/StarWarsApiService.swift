//
//  StarWarsApiService.swift
//  StarWarsApp
//
//  Created by Elena Nazarova on 25.08.2023.
//

import Foundation

final class StarWarsApiService {

    enum ApiError: Error {
        case incorrectType
        case incorrectUrl
        case inner(error: Error)
    }
    
    // MARK: - Private properties
    
    private enum Constants {
        static let urlPath = "https://swapi.dev/api/"
        static let searchPrefix = "?search="
        
        static let peoplePrefix = "people/"
        static let starshipsPrefix = "starships/"
        static let planetsPrefix = "planets/"
    }
    
    private enum ApiSearchingPhase {
        case initial(symbols: String)
        case throughNextPage(urlPath: String)
    }
    
    private var people = [Character]()
    private var starships = [StarShip]()
    private var planets = [Planet]()
    
    // MARK: - Internal methods
    
    func getCharacters(startingWith symbols: String) async throws -> [Character] {
        try await self.collectObject(of: Character.self, in: .initial(symbols: symbols))
        return self.people
    }
    
    func getStarships(startingWith symbols: String) async throws -> [StarShip] {
        try await self.collectObject(of: StarShip.self, in: .initial(symbols: symbols))
        return self.starships
    }
    
    func getPlanets(startingWith symbols: String) async throws -> [Planet] {
        try await self.collectObject(of: Planet.self, in: .initial(symbols: symbols))
        return self.planets
    }
    
    // MARK: - Private methods
    
    private func collectObject<T: Decodable>(of type: T.Type, in phase: ApiSearchingPhase) async throws {
        var urlPath: String
        
        switch phase {
        case .initial(symbols: let symbols):
            let objectTypePrefix: String
            switch type {
            case is Character.Type:
                objectTypePrefix = Constants.peoplePrefix
            case is StarShip.Type:
                objectTypePrefix = Constants.starshipsPrefix
            case is Planet.Type:
                objectTypePrefix = Constants.planetsPrefix
            default:
                throw ApiError.incorrectType
            }

            urlPath = Constants.urlPath + objectTypePrefix + Constants.searchPrefix + symbols
        
        case .throughNextPage(urlPath: let path):
            urlPath = path
        }

        guard let url = URL(string: urlPath) else { throw ApiError.incorrectUrl }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let results = try JSONDecoder().decode(Results<T>.self, from: data)
            
            if let people = results.results as? [Character] {
                self.people.append(contentsOf: people)
            } else if let starships = results.results as? [StarShip] {
                self.starships.append(contentsOf: starships)
            } else if let planets = results.results as? [Planet] {
                self.planets.append(contentsOf: planets)
            }
            
            if let nextPage = results.next {
                try await self.collectObject(of: type, in: .throughNextPage(urlPath: nextPage))
            }
            
        } catch {
            throw ApiError.inner(error: error)
        }
    }
}
