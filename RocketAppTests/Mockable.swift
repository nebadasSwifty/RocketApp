//
//  Mockable.swift
//  RocketAppTests
//
//  Created by Кирилл on 11.01.2023.
//

import Foundation

protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> [T]
}

extension Mockable {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }

    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> [T] {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError()
        }

        do {
            let data = try Data(contentsOf: path)
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedObject = try jsonDecoder.decode([T].self, from: data)

            return decodedObject
        } catch {
            print("Oops... JSON not decoded")
            fatalError()
        }
    }
}
