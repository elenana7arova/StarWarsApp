//
//  PlanetCell.swift
//  StarWarsApp
//
//  Created by Elena Nazarova on 25.08.2023.
//

import UIKit

final class PlanetCell: FavouritesCell {
    
    private enum Constants {
        static let icon = UIImage(named: "planet-icon")!
        static let color = UIColor(named: "gray")!
    }
    
    func updateCell(with planet: Planet, isFavourite: Bool? = nil) {
        self.backgroundColor = Constants.color
        self.selectionStyle = .none
        
        let stack = self.createStack(from: planet)
        super.updateCell(view: stack, isFavoutite: isFavourite, iconImage: Constants.icon)
    }
    
    // MARK: - Private
    
    private func createStack(from planet: Planet) -> UIStackView {
        
        UIStackView.createVStackWithPairedLabels(with: [
            "Название: ": planet.name,
            "Диаметр: ": planet.diameter,
            "Население: ": planet.population,
        ],
                                                              fontSize: 14,
                                                              spacingBetween: 5)
    }
}

