//
//  FavouritesViewController.swift
//  StarWarsApp
//
//  Created by Elena Nazarova on 25.08.2023.
//

import UIKit

final class FavouritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private lazy var tableView: UITableView = { self.createTableView() }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Избранное"
        
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Private
    
    private func setupViews() {
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    private func createTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        return tableView
    }
    
    private func updateTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.tableView.reloadData()
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int { 3 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return CRUDManager.shared.allItems(ofType: FavouritePlanet.self).count
            case 1: return CRUDManager.shared.allItems(ofType: FavouriteStarship.self).count
            case 2: return CRUDManager.shared.allItems(ofType: FavouriteCharacter.self).count
            default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        switch indexPath.section {
            case 0:
                let planetCell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? PlanetCell ?? PlanetCell()
                
                let favPlanet = CRUDManager.shared.allItems(ofType: FavouritePlanet.self)[indexPath.row]
                planetCell.updateCell(with: Self.map(planet: favPlanet), isFavourite: true)
                planetCell.cellTapped = { [weak self] _ in
                    CRUDManager.shared.delete(favPlanet)
                    self?.updateTableView()
                }
                
                cell = planetCell
            
            case 1:
                let starshipCell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? StarShipCell ?? StarShipCell()
                
                let favStarship = CRUDManager.shared.allItems(ofType: FavouriteStarship.self)[indexPath.row]
                starshipCell.updateCell(with: Self.map(starship: favStarship), isFavourite: true)
                starshipCell.cellTapped = { [weak self] _ in
                    CRUDManager.shared.delete(favStarship)
                    self?.updateTableView()
                }
                
                cell = starshipCell
            
            case 2:
                let charactedCell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? CharacterCell ?? CharacterCell()
                
                let favCharacter = CRUDManager.shared.allItems(ofType: FavouriteCharacter.self)[indexPath.row]
                charactedCell.updateCell(with: Self.map(character: favCharacter), isFavourite: true)
                charactedCell.cellTapped = { [weak self] _ in
                    CRUDManager.shared.delete(favCharacter)
                    self?.updateTableView()
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
            case 0: return CRUDManager.shared.allItems(ofType: FavouritePlanet.self).count > 0 ? CellBoldTitleHeader(title: "Планеты") : nil
            case 1: return CRUDManager.shared.allItems(ofType: FavouriteStarship.self).count > 0 ? CellBoldTitleHeader(title: "Корабли") : nil
            case 2: return CRUDManager.shared.allItems(ofType: FavouriteCharacter.self).count > 0 ? CellBoldTitleHeader(title: "Персонажи") : nil
            default: return nil 
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
            case 0: return CRUDManager.shared.allItems(ofType: FavouritePlanet.self).count > 0 ? 30 : 0
            case 1: return CRUDManager.shared.allItems(ofType: FavouriteStarship.self).count > 0 ? 30 : 0
            case 2: return CRUDManager.shared.allItems(ofType: FavouriteCharacter.self).count > 0 ? 30 : 0
            default: return 0.0
        }
    }
    
    // MARK: - Static
    
    private static func map(character: FavouriteCharacter) -> Character {
        Character(name: character.name,
                  gender: .init(rawValue: character.gender),
                  starshipsPiloted: character.shipsPiloted,
                  id: character.id)
    }
    
    private static func map(starship: FavouriteStarship) -> StarShip {
        StarShip(name: starship.name,
                 model: starship.model,
                 manufacturer: starship.manufacturer,
                 passengers: starship.passengers,
                 id: starship.id)
    }
    
    private static func map(planet: FavouritePlanet) -> Planet {
        Planet(name: planet.name,
               diameter: planet.diameter,
               population: planet.population,
               id: planet.id)
    }
}

