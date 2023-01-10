//
//  LaunchesViewController.swift
//  RocketApp
//
//  Created Кирилл on 08.01.2023.
//

import UIKit

final class LaunchesViewController: UIViewController, LaunchesViewProtocol {
	var presenter: LaunchesPresenterProtocol
    private var launchesView: LaunchesView! {
        return view as? LaunchesView
    }

	init(presenter: LaunchesPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = LaunchesView()
    }

	override func viewDidLoad() {
        super.viewDidLoad()

        presenter.view = self
        presenter.viewDidLoad()
        
        launchesView.tableView.delegate = self
        launchesView.tableView.dataSource = self
    }
    
    func initialSetup() {
        launchesView.tableView.reloadData()
    }
}

extension LaunchesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension LaunchesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.launches.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchCell") as? LaunchCell else { return UITableViewCell() }
        let launch = presenter.launches[indexPath.row]
        cell.configureCell(name: launch.name, date: launch.dateLocal.formatStringToDate(initialFormat: "yyyy-MM-dd'T'HH:mm:ssZ")?.toString(formatter: "dd MMMM, yyyy") ?? "", status: Bool(launch.success ?? false) )
        
        return cell
    }
}
