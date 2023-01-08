//
//  Launch.swift
//  RocketApp
//
//  Created by Кирилл on 08.01.2023.
//

import Foundation

typealias Launches = [LaunchElement]

// MARK: - LaunchElement
struct LaunchElement: Decodable {
    let name: String
    let dateLocal: String
    let rocket: String
    let success: Bool?
}

