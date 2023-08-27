//
//  UIStackView+Extension.swift
//  StarWarsApp
//
//  Created by Elena Nazarova on 27.08.2023.
//

import UIKit

extension UIStackView {
    
    static func createVStackWithPairedLabels(with text: [String: String],
                                             fontSize: CGFloat,
                                             spacingBetween: CGFloat) -> UIStackView {
        let labels = text.map { title, value in
            let label = UILabel()
            label.numberOfLines = 0
            
            let titleAttr = title.createAttributedString(fontSize: fontSize,
                                                         isBold: true,
                                                         alignment: .left,
                                                         color: .black)
            
            let valueAttr = value.createAttributedString(fontSize: fontSize,
                                                         isBold: false,
                                                         alignment: .left,
                                                         color: .black)
            let finalAttr = NSMutableAttributedString(attributedString: titleAttr)
            finalAttr.append(valueAttr)
            label.attributedText = finalAttr
            return label
        }
        
        let stack = UIStackView(arrangedSubviews: labels)
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = spacingBetween
        return stack
    }
}
