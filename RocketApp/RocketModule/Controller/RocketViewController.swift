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

        rocketView.addViewToContainer(view: HeaderLabel(headerName: rocket.name,
                                                        fontSize: 24,
                                                        imageName: "gear",
                                                        buttonAction: { [weak self] in
            self?.present(settingsViewController, animated: true)
        }))

        rocketView.addViewToContainer(view: InfoCollectionView(frame: .zero, dataSource: self))
        rocketView.addViewToContainer(view: InfoLabel(name: "Первый запуск",
                                                      value: rocket.firstFlight
                                                                .formatStringToDate(initialFormat: "yyyy-MM-dd")?
                                                                .toString(formatter: "dd MMMM, yyyy") ?? ""))
        rocketView.addViewToContainer(view: InfoLabel(name: "Страна", value: rocket.country))
        rocketView.addViewToContainer(view: InfoLabel(name: "Стоимость запуска",
                                                      value: "$\(rocket.costPerLaunch.formatUsingAbbrevation())"))
        rocketView.addViewToContainer(view: HeaderLabel(headerName: "ПЕРВАЯ СТУПЕНЬ"))
        rocketView.addViewToContainer(view: InfoLabel(name: "Количество двигателей",
                                                      value: "\(rocket.firstStage.engines)"))

        let firstStageFuelAmounts = NSMutableAttributedString(string: "\(rocket.firstStage.fuelAmountTons) tons")
        firstStageFuelAmounts.setColorForText("tons", with: .gray)
        rocketView.addViewToContainer(view: InfoLabel(name: "Количество топлива",
                                                      attributedValue: firstStageFuelAmounts))

        let firstStageBurnTime = NSMutableAttributedString(string: "\(rocket.firstStage.burnTimeSec ?? 0) sec")
        firstStageBurnTime.setColorForText("sec", with: .gray)
        rocketView.addViewToContainer(view: InfoLabel(name: "Время сгорания", attributedValue: firstStageBurnTime))
        rocketView.addViewToContainer(view: HeaderLabel(headerName: "ВТОРАЯ СТУПЕНЬ"))
        rocketView.addViewToContainer(view: InfoLabel(name: "Количество двигателей",
                                                      value: "\(rocket.secondStage.engines)"))

        let secondStageFuelAmounts = NSMutableAttributedString(string: "\(rocket.secondStage.fuelAmountTons) tons")
        secondStageFuelAmounts.setColorForText("tons", with: .gray)
        rocketView.addViewToContainer(view: InfoLabel(name: "Количество топлива",
                                                      attributedValue: secondStageFuelAmounts))

        let secondStageBurnTime = NSMutableAttributedString(string: "\(rocket.secondStage.burnTimeSec ?? 0) sec")
        secondStageBurnTime.setColorForText("sec", with: .gray)
        rocketView.addViewToContainer(view: InfoLabel(name: "Время сгорания", attributedValue: secondStageBurnTime))

        let launchesPresenter = LaunchesPresenter(rocketId: rocket.id)
        let launchesViewController = LaunchesViewController(presenter: launchesPresenter)
        launchesViewController.title = rocket.name

        rocketView.addViewToContainer(view: ButtonView(titleButton: "Посмотреть запуски", buttonAction: { [weak self] in
            launchesPresenter.networkService = (self?.parent as? RocketPageViewController)?.presenter?.networkService
            self?.navigationController?.pushViewController(launchesViewController, animated: true)
        }))
    }
}

extension RocketViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable line_length
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCell", for: indexPath) as? InfoCell else {
            return UICollectionViewCell()
        }
        switch indexPath.row {
        case 0:
            if let heightUnit = UserDefaults.standard.string(forKey: "height") {
                let height = heightUnit == "ft" ? rocket.height.feet : rocket.height.meters
                cell.configure(name: "Высота, \(heightUnit)", value: "\(height ?? 0)")
            } else {
                cell.configure(name: "Высота, m", value: "\(rocket.height.meters ?? 0)")
            }
        case 1:
            if let diameterUnit = UserDefaults.standard.string(forKey: "diameter") {
                let diameter = diameterUnit == "ft" ? rocket.diameter.feet : rocket.diameter.meters
                cell.configure(name: "Диаметр, \(diameterUnit)", value: "\(diameter ?? 0)")
            } else {
                cell.configure(name: "Диаметр, m", value: "\(rocket.diameter.meters ?? 0)")
            }
        case 2:
            if let massUnit = UserDefaults.standard.string(forKey: "mass") {
                let mass = massUnit == "kg" ? rocket.mass.kg : rocket.mass.lb
                cell.configure(name: "Масса, \(massUnit)", value: "\(mass)")
            } else {
                cell.configure(name: "Масса, kg", value: "\(rocket.mass.kg)")
            }
        case 3:
            if let payloadUnit = UserDefaults.standard.string(forKey: "payload") {
                let payload = payloadUnit == "kg" ? rocket.payloadWeights.first(where: { $0.id == "leo" })?.kg : rocket.payloadWeights.first(where: { $0.id == "leo" })?.lb
                cell.configure(name: "Нагрузка, \(payloadUnit)", value: "\(payload ?? 0)")
            } else {
                cell.configure(name: "Нагрузка, kg", value: "\(rocket.payloadWeights.first(where: { $0.id == "leo" })?.kg ?? 0)")
            }
        default:
            break
        }

        return cell
    }
}
