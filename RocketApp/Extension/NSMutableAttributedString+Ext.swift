//
//  NSMutableAttributedString+Ext.swift
//  RocketApp
//
//  Created by Кирилл on 11.01.2023.
//

import UIKit

extension NSMutableAttributedString {
    func setColorForText(_ textToFind: String, with color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
}
