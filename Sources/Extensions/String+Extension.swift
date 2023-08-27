//
//  String+Extension.swift
//  StarWarsApp
//
//  Created by Elena Nazarova on 26.08.2023.
//

import UIKit

extension String {
    
    func createAttributedString(fontSize: CGFloat,
                                isBold: Bool,
                                alignment: NSTextAlignment,
                                color: UIColor) -> NSAttributedString {
        let font = isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle
        ]
        return NSAttributedString(string: self, attributes: attributes)
    }
}
