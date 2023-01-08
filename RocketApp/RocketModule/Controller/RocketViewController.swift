//
//  RocketView.swift
//  RocketApp
//
//  Created by Кирилл on 27.11.2022.
//

import UIKit

final class RocketViewController: UIViewController {
    private var rocket: Rocket
    private var rocketView: RocketView! {
        return view as? RocketView
    }
    
    init(rocket: Rocket) {
        self.rocket = rocket
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = RocketView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func setupImage(from data: Data?) {
        guard let data = data else { return }
        rocketView.setupImageToView(data: data)
    }
    
    private func configure() {
        let settingsViewController = SettingsController()
        
        rocketView.addViewToContainer(view: HeaderLabel(headerName: rocket.name, fontSize: 24, imageName: "gear", buttonAction: { [weak self] in
            self?.present(settingsViewController, animated: true)
        }))
        
        rocketView.addViewToContainer(view: InfoCollectionView(frame: .zero, dataSource: self))
        rocketView.addViewToContainer(view: InfoLabel(name: "Первый запуск", value: rocket.firstFlight.formatStringToDate(initialFormat: "yyyy-MM-dd")?.toString(formatter: "dd MMMM, yyyy") ?? ""))
        rocketView.addViewToContainer(view: InfoLabel(name: "Страна", value: rocket.country))
        rocketView.addViewToContainer(view: InfoLabel(name: "Стоимость запуска", value: "\(rocket.costPerLaunch)"))
        rocketView.addViewToContainer(view: HeaderLabel(headerName: "ПЕРВАЯ СТУПЕНЬ"))
        rocketView.addViewToContainer(view: InfoLabel(name: "Количество двигателей", value: "\(rocket.firstStage.engines)"))
        rocketView.addViewToContainer(view: InfoLabel(name: "Количество топлива", value: "\(rocket.firstStage.fuelAmountTons)"))
        rocketView.addViewToContainer(view: InfoLabel(name: "Время сгорания", value: "\(rocket.firstStage.burnTimeSEC ?? 0)"))
        rocketView.addViewToContainer(view: HeaderLabel(headerName: "ВТОРАЯ СТУПЕНЬ"))
        rocketView.addViewToContainer(view: InfoLabel(name: "Количество двигателей", value: "\(rocket.secondStage.engines)"))
        rocketView.addViewToContainer(view: InfoLabel(name: "Количество топлива", value: "\(rocket.secondStage.fuelAmountTons)"))
        rocketView.addViewToContainer(view: InfoLabel(name: "Время сгорания", value: "\(rocket.secondStage.burnTimeSEC ?? 0)"))
        
        let launchesPresenter = LaunchesPresenter(rocketId: rocket.id, networkService: (parent as? RocketPageViewController)?.presenter?.networkService)
        let launchesViewController = LaunchesViewController(presenter: launchesPresenter)
        launchesViewController.title = rocket.name
        
        rocketView.addViewToContainer(view: ButtonView(titleButton: "Посмотреть запуски", buttonAction: { [weak self] in
            self?.navigationController?.pushViewController(launchesViewController, animated: true)
        }))
    }
}

extension RocketViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCell", for: indexPath) as? InfoCell else { return UICollectionViewCell() }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        switch indexPath.row {
        case 0:
            let formattedNumber = numberFormatter.string(from: NSNumber(value: rocket.height.feet ?? 0))
            cell.configure(name: "Высота", value: "\(formattedNumber ?? "")")
        case 1:
            let formattedNumber = numberFormatter.string(from: NSNumber(value: rocket.diameter.feet ?? 0))
            cell.configure(name: "Диаметр", value: "\(formattedNumber ?? "")")
        case 2:
            let formattedNumber = numberFormatter.string(from: NSNumber(value: rocket.mass.kg))
            cell.configure(name: "Масса", value: "\(formattedNumber ?? "")")
        case 3:
            let formattedNumber = numberFormatter.string(from: NSNumber(value: rocket.payloadWeights.first(where: { $0.id == "leo" })?.kg ?? 0))
            cell.configure(name: "Нагрузка", value: "\(formattedNumber ?? "")")
        default:
            break
        }
        
        return cell
    }
}
