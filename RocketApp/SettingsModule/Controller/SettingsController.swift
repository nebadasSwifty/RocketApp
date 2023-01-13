//
//  SettingsController.swift
//  RocketApp
//
//  Created by Кирилл on 09.01.2023.
//

import UIKit

final class SettingsController: UIViewController {
    var settingView: SettingsView! {
        return view as? SettingsView
    }

    override func loadView() {
        view = SettingsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        isModalInPresentation = true
        settingView.addViewToContainer(view: HeaderBar(closeButtonAction: { [weak self] in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadData"), object: nil)
            self?.dismiss(animated: true)
        }))
        settingView.addViewToContainer(view: SettingView(nameSetting: "height",
                                                         name: "Высота",
                                                         segmentNames: ["m", "ft"]))
        settingView.addViewToContainer(view: SettingView(nameSetting: "diameter",
                                                         name: "Диаметр",
                                                         segmentNames: ["m", "ft"]))
        settingView.addViewToContainer(view: SettingView(nameSetting: "mass",
                                                         name: "Масса",
                                                         segmentNames: ["kg", "lb"]))
        settingView.addViewToContainer(view: SettingView(nameSetting: "payload",
                                                         name: "Полезная нагрузка",
                                                         segmentNames: ["kg", "lb"]))
    }
}
