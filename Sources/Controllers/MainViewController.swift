//
//  MainViewController.swift
//  StarWarsApp
//
//  Created by Elena Nazarova on 25.08.2023.
//

import UIKit
import CoreData

final class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private lazy var searchField: UISearchTextField = { self.createSearchField() }()
    private lazy var tableView: UITableView = { self.createTableView() }()
    private lazy var loader: UIActivityIndicatorView = { self.createLoader() }()
    
    private var characters = [Character]()
    private var starships = [StarShip]()
    private var planets = [Planet]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Поиск"
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    // MARK: - Private
    
    private func setupViews() {
        self.view.addSubview(self.searchField)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.loader)
        
        NSLayoutConstraint.activate([
            self.searchField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.searchField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.searchField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            self.tableView.topAnchor.constraint(equalTo: self.searchField.bottomAnchor, constant: 10),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            self.loader.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor),
            self.loader.centerYAnchor.constraint(equalTo: self.tableView.centerYAnchor)
        ])
    }
    
    private func createSearchField() -> UISearchTextField {
        let searchField = UISearchTextField()
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.autocorrectionType = .no
        searchField.placeholder = "Это ловушка!"
        searchField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        return searchField
    }
    
    private func createTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = UITableView.automaticDimension
        return tableView
    }
    
    private func createLoader() -> UIActivityIndicatorView {
        let loader = UIActivityIndicatorView(style: .large)
        loader.color = .black
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.isHidden = true
        return loader
    }
    
    @objc
    private func textFieldDidChange(_ sender: UITextField) {
        guard let text = sender.text, text.count > 1 else {
            self.starships.removeAll()
            self.characters.removeAll()
            self.planets.removeAll()
            
            self.updateTableView()
            self.stopLoading()
            return
        }
        
        self.startLoading()
        
        Task {
            async let characters = try StarWarsApiService().getCharacters(startingWith: text)
            async let starships = try StarWarsApiService().getStarships(startingWith: text)
            async let planets = try StarWarsApiService().getPlanets(startingWith: text)
            
            (self.characters, self.starships, self.planets) = await (try characters, try starships, try planets)

            self.updateTableView()
            self.stopLoading()
        }
    }
    
    private func updateTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.tableView.reloadData()
        }
    }
    
    private func startLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.loader.startAnimating()
            self.loader.isHidden = false
            self.tableView.isHidden = true
        }
    }
    
    private func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.loader.stopAnimating()
            self.loader.isHidden = true
            self.tableView.isHidden = false
        }
    }
    
    // MARK: - Database
    
    private func save(character: Character) {
        CRUDManager.shared.create(ofType: FavouriteCharacter.self, withKeyValue: [
            "name": character.name,
            "gender": character.gender?.rawValue,
            "shipsPiloted": character.starshipsPiloted,
            "id": character.id
        ])
    }
    
    private func save(starship: StarShip) {
        CRUDManager.shared.create(ofType: FavouriteStarship.self, withKeyValue: [
            "name": starship.name,
            "model": starship.model,
            "manufacturer": starship.manufacturer,
            "passengers": starship.passengers,
            "id": starship.id
        ])
    }
    
    private func save(planet: Planet) {
        CRUDManager.shared.create(ofType: FavouritePlanet.self, withKeyValue: [
            "name": planet.name,
            "diameter": planet.diameter,
            "population": planet.population,
            "id": planet.id
        ])
    }
    
    private func remove(character: Character) {
        let allItems = CRUDManager.shared.allItems(ofType: FavouriteCharacter.self)
        guard let currentItem = allItems.first(where: { $0.id == character.id }) else { return }
        CRUDManager.shared.delete(currentItem)
    }
    
    private func remove(planet: Planet) {
        let allItems = CRUDManager.shared.allItems(ofType: FavouritePlanet.self)
        guard let currentItem = allItems.first(where: { $0.id == planet.id }) else { return }
        CRUDManager.shared.delete(currentItem)
    }
    
    private func remove(starship: StarShip) {
        let allItems = CRUDManager.shared.allItems(ofType: FavouriteStarship.self)
        guard let currentItem = allItems.first(where: { $0.id == starship.id }) else { return }
        CRUDManager.shared.delete(currentItem)
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int { 3 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return self.planets.count
        case 1: return self.starships.count
        case 2: return self.characters.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        switch indexPath.section {
            case 0:
                let planetCell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? PlanetCell ?? PlanetCell()
                
                let currentPlanet = self.planets[indexPath.row]
                let savedPlanets = CRUDManager.shared.allItems(ofType: FavouritePlanet.self)
                
                let isAlreadyFavourite = savedPlanets.contains(where: { $0.id == currentPlanet.id })
                
                planetCell.updateCell(with: currentPlanet, isFavourite: isAlreadyFavourite)
                planetCell.cellTapped = { [weak self] isFavourite in
                    isFavourite ? self?.save(planet: currentPlanet) : self?.remove(planet: currentPlanet)
                }
                
                cell = planetCell
            
            case 1:
                let starshipCell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? StarShipCell ?? StarShipCell()
                
                let currentStarship = self.starships[indexPath.row]
                let savedStarships = CRUDManager.shared.allItems(ofType: FavouriteStarship.self)
                
                let isAlreadyFavourite = savedStarships.contains(where: { $0.id == currentStarship.id })
                
                starshipCell.updateCell(with: currentStarship, isFavourite: isAlreadyFavourite)
                starshipCell.cellTapped = { [weak self] isFavourite in
                    isFavourite ? self?.save(starship: currentStarship) : self?.remove(starship: currentStarship)
                }
                
                cell = starshipCell
            
            case 2:
                let charactedCell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? CharacterCell ?? CharacterCell()
                
                let currentCharacter = self.characters[indexPath.row]
                let savedCharacters = CRUDManager.shared.allItems(ofType: FavouriteCharacter.self)
                
                let isAlreadyFavourite = savedCharacters.contains(where: { $0.id == currentCharacter.id })
                
                charactedCell.updateCell(with: currentCharacter, isFavourite: isAlreadyFavourite)
                charactedCell.cellTapped = { [weak self] isFavourite in
                    isFavourite ? self?.save(character: currentCharacter) : self?.remove(character: currentCharacter)
                }
                cell = charactedCell
            default:
                cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        }

        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
            case 0: return self.planets.count > 0 ? CellBoldTitleHeader(title: "Планеты") : nil
            case 1: return self.starships.count > 0 ? CellBoldTitleHeader(title: "Корабли") : nil
            case 2: return self.characters.count > 0 ? CellBoldTitleHeader(title: "Персонажи") : nil
            default: return nil 
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
            case 0: return self.planets.count > 0 ? 30 : 0
            case 1: return self.starships.count > 0 ? 30 : 0
            case 2: return self.characters.count > 0 ? 30 : 0
            default: return 0.0
        }
    }
}
