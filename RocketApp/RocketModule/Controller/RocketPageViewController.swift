//
//  RocketPageViewController.swift
//  RocketApp
//
//  Created by Кирилл on 27.11.2022.
//

import UIKit

final class RocketPageViewController: UIPageViewController {
    private var loadingView: UIActivityIndicatorView?
    var presenter: RocketPresenterProtocol?

    init(presenter: RocketPresenterProtocol? = nil) {
        self.presenter = presenter
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLoadingView()
        dataSource = self
        delegate = self
        view.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)

        presenter?.view = self
        presenter?.viewDidLoad()
    }

    private func setupLoadingView() {
        loadingView = UIActivityIndicatorView()
        loadingView?.hidesWhenStopped = true
        view.addSubview(loadingView!)
        loadingView?.center = view.center
        loadingView?.startAnimating()
    }
}

extension RocketPageViewController: RocketViewProtocol {
    func setView(view: RocketViewController?) {
        guard let view = view else { return }

        setViewControllers([view], direction: .forward, animated: true)
        loadingView?.stopAnimating()
    }
}

extension RocketPageViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return presenter?.rocketViews.count ?? 0
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        if let currentVC = viewControllers?.first as? RocketViewController,
           let rocketViews = presenter?.rocketViews,
           let currentIndex = rocketViews.firstIndex(of: currentVC) {
            return currentIndex
        } else {
            return 0
        }
     }
}

extension RocketPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? RocketViewController,
              let rocketViews = presenter?.rocketViews,
              let viewControllerIndex = rocketViews.firstIndex(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return rocketViews.last }
        guard rocketViews.count > previousIndex else { return nil }
        return rocketViews[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? RocketViewController,
              let rocketViews = presenter?.rocketViews,
              let viewControllerIndex = rocketViews.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        guard nextIndex >= 0 else { return rocketViews.first }
        guard rocketViews.count > nextIndex else { return nil }
        return rocketViews[nextIndex]
    }
}
