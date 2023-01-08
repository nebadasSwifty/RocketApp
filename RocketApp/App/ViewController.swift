//
//  ViewController.swift
//  RocketApp
//
//  Created by Кирилл on 27.11.2022.
//

import UIKit

class ViewController: UIViewController {
    var rocketPageViewController: RocketPageViewController?
    var networkService: NetworkService?
    var rocketPresenter: RocketPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService = NetworkServiceImpl()
        rocketPresenter = RocketPresenter(networkService: networkService)
        rocketPageViewController = RocketPageViewController(presenter: rocketPresenter)
        
        if let rocketPageViewController = rocketPageViewController {
            navigationController?.navigationBar.barStyle = .black
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationController?.setViewControllers([rocketPageViewController], animated: true)
        }
    }
}

