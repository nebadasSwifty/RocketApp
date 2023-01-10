//
//  ViewController.swift
//  RocketApp
//
//  Created by Кирилл on 27.11.2022.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkService = NetworkServiceImpl()
        let rocketPresenter = RocketPresenter(networkService: networkService)
        let rocketPageViewController = RocketPageViewController(presenter: rocketPresenter)
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.setViewControllers([rocketPageViewController], animated: true)
    }
}

