//
//  Rocket.swift
//  RocketApp
//
//  Created by Кирилл on 27.11.2022.
//

typealias Rockets = [Rocket]

// swiftlint:disable all
struct Rocket: Decodable {
    let height: Diameter
    let diameter: Diameter
    let mass: Mass
    let firstStage: FirstStage
    let secondStage: SecondStage
    let payloadWeights: [PayloadWeight]
    let flickrImages: [String]
    let name: String
    let costPerLaunch: Int
    let firstFlight: String
    let country: String
    let id: String
}

extension Rocket {
    // MARK: - Diameter
    struct Diameter: Decodable {
        let meters: Double?
        let feet: Double?
    }

    // MARK: - FirstStage
    struct FirstStage: Decodable {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSec: Int?
    }

    // MARK: - Mass
    struct Mass: Decodable {
        let kg: Int
        let lb: Int
    }

    // MARK: - PayloadWeight
    struct PayloadWeight: Decodable {
        let id: String
        let name: String
        let kg: Int
        let lb: Int
    }

    // MARK: - SecondStage
    struct SecondStage: Decodable {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSec: Int?
    }
}
