//
//  LaunchesPresenter.swift
//  RocketApp
//
//  Created Кирилл on 08.01.2023.
//

import UIKit

// MARK: View -
protocol LaunchesViewProtocol: AnyObject {
    func initialSetup()
}

//MARK: Error -
enum LaunchesPresenterError: Error {
    case launchesIsEmpty
}

// MARK: Presenter -
protocol LaunchesPresenterProtocol: AnyObject {
	var view: LaunchesViewProtocol? { get set }
    var launches: Launches { get set }
    func viewDidLoad()
}

final class LaunchesPresenter: LaunchesPresenterProtocol {
    weak var view: LaunchesViewProtocol?
    private var rocketId: String?
    var networkService: NetworkService?
    var launches: Launches = []
    
    init(view: LaunchesViewProtocol? = nil, rocketId: String? = nil) {
        self.view = view
        self.rocketId = rocketId
    }

    func viewDidLoad() {
        networkService?.get(from: .launches, completionHandler: { [weak self] (result: Result<Launches, Error>) in
            switch result {
            case .success(let launches):
                guard !launches.isEmpty else {
                    (self?.view as? UIViewController)?.presentError(error: LaunchesPresenterError.launchesIsEmpty)
                    return
                }
                
                self?.launches = launches.filter({ $0.rocket == self?.rocketId })
                DispatchQueue.main.async {
                    self?.view?.initialSetup()
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    (self?.view as? UIViewController)?.presentError(error: failure)
                }
            }
        })
    }
}
