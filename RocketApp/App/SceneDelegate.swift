//
//  SceneDelegate.swift
//  RocketApp
//
//  Created by Кирилл on 27.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        let networkService = NetworkServiceImpl()
        let rocketPresenter = RocketPresenter(networkService: networkService)
        let rocketPageViewController = RocketPageViewController(presenter: rocketPresenter)
        let navigationController = UINavigationController(rootViewController: rocketPageViewController)

        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
