//
//  String+Ext.swift
//  RocketApp
//
//  Created by Кирилл on 04.01.2023.
//

import Foundation

extension String {
    func formatStringToDate(initialFormat from: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = from
        return dateFormatter.date(from: self)
    }
}
