//
//  RocketViewBuilder.swift
//  RocketApp
//
//  Created by Кирилл on 27.11.2022.
//

import UIKit

protocol RocketViewBuilder {
    static func buildViews(for: Rocket) -> RocketViewController
}

final class RocketViewBuilderImpl: RocketViewBuilder {
    static func buildViews(for rocket: Rocket) -> RocketViewController {
        return RocketViewController(rocket: rocket)
    }
}
