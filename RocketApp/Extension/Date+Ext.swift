//
//  Date+Ext.swift
//  RocketApp
//
//  Created by Кирилл on 04.01.2023.
//

import Foundation

extension Date {
    func toString(formatter: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: self)
    }
}
