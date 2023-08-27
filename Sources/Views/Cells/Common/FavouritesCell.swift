//
//  FavouritesCell.swift
//  StarWarsApp
//
//  Created by Elena Nazarova on 25.08.2023.
//

import UIKit

class FavouritesCell: UITableViewCell {
    
    private var isFavourite = false
    
    private var view: UIView?
    private var icon: UIImage?
    private var heartImageView: UIImageView?

    typealias BoolCompletion = (Bool) -> Void
    var cellTapped: BoolCompletion?
    
    func updateCell(view: UIView, isFavoutite: Bool? = nil, iconImage: UIImage? = nil) {
        self.view = view
        self.icon = iconImage
        if let isFavoutite { self.isFavourite = isFavoutite }
        self.setupHeartButton()
        self.layoutIfNeeded()
    }
    
    // MARK: - Private
    
    private func setupHeartButton() {
        guard let view else { return }
        
        let heartImage = Self.image(isFavourite: self.isFavourite)
        let heartImageView = UIImageView(image: heartImage)
        heartImageView.isUserInteractionEnabled = true
        heartImageView.tintColor = UIColor(named: "pink")
        self.heartImageView = heartImageView
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.heartTapped(_:)))
        heartImageView.addGestureRecognizer(tap)
        
        let hStack = UIStackView(arrangedSubviews: [view, heartImageView])
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.spacing = 10
        
        self.contentView.addSubview(hStack)
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            hStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            hStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            hStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])
        
        if let icon {
            let imageView = UIImageView(image: icon)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            hStack.insertArrangedSubview(imageView, at: 0)
            
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 40)
            ])
        }
    }
    
    @objc
    private func heartTapped(_ sender: UIImageView) {
        self.isFavourite.toggle()
        self.heartImageView?.image = Self.image(isFavourite: self.isFavourite)
        self.cellTapped?(self.isFavourite)
    }
    
    private static func image(isFavourite: Bool) -> UIImage? {
        isFavourite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
    }
}
