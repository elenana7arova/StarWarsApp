//
//  CellBoldTitleHeader.swift
//  StarWarsApp
//
//  Created by Elena Nazarova on 26.08.2023.
//

import UIKit

final class CellBoldTitleHeader: UIView {
    
    init(title: String, color: UIColor = .black) {
        super.init(frame: .zero)
        self.setupView(with: title, color: color)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setupView(with title: String, color: UIColor) {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = title.createAttributedString(fontSize: 18, isBold: true, alignment: .left, color: color)
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}
