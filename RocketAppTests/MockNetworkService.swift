//
//  MockNetworkService.swift
//  RocketAppTests
//
//  Created by Кирилл on 11.01.2023.
//

import Foundation
@testable import RocketApp

final class MockNetworkService: NetworkService, Mockable {
    func get<T>(from: RocketApp.Endpoint, completionHandler: @escaping (Result<[T], Error>) -> Void) where T : Decodable {
        if from == .rockets {
            completionHandler(.success(loadJSON(filename: "RocketResponse", type: T.self)))
        } else {
            completionHandler(.success(loadJSON(filename: "LaunchesResponse", type: T.self)))
        }
    }
    
    func fetchImage(url: String?, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        guard let data = Data(base64Encoded: url ?? "") else { return }
        completionHandler(.success(data))
    }
}
