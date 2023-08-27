//
//  CharacterCell.swift
//  StarWarsApp
//
//  Created by Elena Nazarova on 25.08.2023.
//

import UIKit

final class CharacterCell: FavouritesCell {
    
    private enum Constants {
        static let icon = UIImage(named: "person-icon")!
        static let color = UIColor(named: "yellow")!
    }

    func updateCell(with character: Character, isFavourite: Bool? = nil) {
        self.backgroundColor = Constants.color
        self.selectionStyle = .none
        
        let stack = self.createStack(from: character)
        super.updateCell(view: stack, isFavoutite: isFavourite, iconImage: Constants.icon)
    }
    
    // MARK: - Private
    
    private func createStack(from character: Character) -> UIStackView {
        let gender: String
        switch character.gender {
            case .male: gender = "♂"
            case .female: gender = "♀"
            default: gender = "❓"
        }
        
        return UIStackView.createVStackWithPairedLabels(with: [
            "Имя: ": character.name,
            "Пол: ": gender,
            "Пилотируемых звездолетов: ": String(character.starshipsPiloted),
        ],
                                                              fontSize: 14,
                                                              spacingBetween: 5)
    }
}
