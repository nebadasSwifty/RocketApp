//
//  NetworkService.swift
//  RocketApp
//
//  Created by Кирилл on 27.11.2022.
//

import Foundation

enum Endpoint: String {
    case launches = "https://api.spacexdata.com/v4/launches"
    case rockets = "https://api.spacexdata.com/v4/rockets"
}

enum NetworkError: Error {
    case endpointIsInvalid
    case responseError
    case dataIsInvalid
    case dataParsingFailed
}

protocol NetworkService {
    func get<T: Decodable>(from: Endpoint, completionHandler: @escaping (Result<[T], Error>) -> Void)
    func fetchImage(url: String?, completionHandler: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkServiceImpl: NetworkService {
    private let urlSession = URLSession(configuration: .default)

    func get<T: Decodable>(from endpoint: Endpoint, completionHandler: @escaping (Result<[T], Error>) -> Void) {
        guard let url = URL(string: endpoint.rawValue) else {
            completionHandler(.failure(NetworkError.endpointIsInvalid))
            return
        }

        urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
            }

            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                completionHandler(.failure(NetworkError.responseError))
                return
            }

            guard let data = data else {
                completionHandler(.failure(NetworkError.dataIsInvalid))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedData = try decoder.decode([T].self, from: data)
                completionHandler(.success(decodedData))
            } catch {
                completionHandler(.failure(NetworkError.dataParsingFailed))
            }
        }.resume()
    }

    func fetchImage(url: String?, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        guard let urlString = url,
              let url = URL(string: urlString) else {
            completionHandler(.failure(NetworkError.endpointIsInvalid))
            return
        }

        urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
            }

            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                completionHandler(.failure(NetworkError.responseError))
                return
            }

            guard let data = data else {
                completionHandler(.failure(NetworkError.dataIsInvalid))
                return
            }

            completionHandler(.success(data))
        }.resume()
    }
}
