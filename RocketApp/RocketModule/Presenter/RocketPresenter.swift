//
//  RocketPresenter.swift
//  RocketApp
//
//  Created Кирилл on 27.11.2022.
//

import UIKit

// MARK: View -
protocol RocketViewProtocol: AnyObject {
    func setView(view: RocketViewController?)
}

// MARK: Error -
enum RocketPresenterError: Error {
    case rocketsIsEmpty
}

// MARK: Presenter -
protocol RocketPresenterProtocol: AnyObject {
    var rocketViews: [RocketViewController] { get }
    var view: RocketViewProtocol? { get set }
    var networkService: NetworkService? { get set }
    func viewDidLoad()
}

final class RocketPresenter: RocketPresenterProtocol {
    weak var view: RocketViewProtocol?
    var networkService: NetworkService?
    var rocketViews: [RocketViewController] = []
    
    init(view: RocketViewProtocol? = nil, networkService: NetworkService? = nil) {
        self.view = view
        self.networkService = networkService
    }
    
    func viewDidLoad() {
        networkService?.get(from: .rockets, completionHandler: { [weak self] (result: Result<Rockets, Error>) in
            switch result {
            case .success(let rockets):
                guard !rockets.isEmpty else {
                    (self?.view as? UIViewController)?.presentError(error: RocketPresenterError.rocketsIsEmpty)
                    return
                }
                
                let group = DispatchGroup()
                var imageDatas: [String?: Data] = [:]
                
                rockets.forEach({ rocket in
                    group.enter()
                    self?.networkService?.fetchImage(url: rocket.flickrImages.first, completionHandler: { result in
                        switch result {
                        case .success(let data):
                            imageDatas[rocket.flickrImages.first] = data
                        case .failure(let error):
                            print(String(describing: error))
                        }

                        group.leave()
                    })
                    
                    group.notify(queue: .main) {
                        let rocketView = RocketViewBuilderImpl.buildViews(for: rocket)
                        rocketView.setupImage(from: imageDatas[rocket.flickrImages.first])
                        self?.rocketViews.append(rocketView)
                        
                        if self?.rocketViews.count ?? 0 == rockets.count {
                            self?.view?.setView(view: self?.rocketViews.first)
                        }
                    }
                })
            case .failure(let error):
                DispatchQueue.main.async {
                    (self?.view as? UIViewController)?.presentError(error: error)
                }
            }
        })
    }
}
