//
//  StarShipCell.swift
//  StarWarsApp
//
//  Created by Elena Nazarova on 25.08.2023.
//

import UIKit

final class StarShipCell: FavouritesCell {
    
    private enum Constants {
        static let icon = UIImage(named: "starship-icon")!
        static let color = UIColor(named: "blue")!
    }
    
    func updateCell(with starship: StarShip, isFavourite: Bool? = nil) {
        self.backgroundColor = Constants.color
        self.selectionStyle = .none
        
        let stack = self.createStack(from: starship)
        super.updateCell(view: stack, isFavoutite: isFavourite, iconImage: Constants.icon)
    }
    
    // MARK: - Private
    
    private func createStack(from starhip: StarShip) -> UIStackView {
        UIStackView.createVStackWithPairedLabels(with: [
            "Имя: ": starhip.name,
            "Модель: ": starhip.model,
            "Производитель: ": starhip.manufacturer,
            "Количество пассажиров: ": starhip.passengers
        ],
                                                              fontSize: 14,
                                                              spacingBetween: 5)
    }
}
