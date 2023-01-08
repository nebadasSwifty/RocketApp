//
//  SettingView.swift
//  RocketApp
//
//  Created by Кирилл on 09.01.2023.
//

import UIKit

final class SettingView: UIView {
    private var container: UIStackView!
    private var nameLabel: UILabel!
    private var settingSegment: UISegmentedControl!
    private var nameSetting: String
    
    init(nameSetting: String, name: String, segmentNames: [String]) {
        self.nameSetting = nameSetting
        super.init(frame: .zero)
        setupContainer()
        setupNameLabel(name: name)
        setupSettingSegment(segmentNames: segmentNames)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContainer() {
        container = UIStackView(frame: .zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)
        container.axis = .horizontal
        container.distribution = .fillProportionally
    }
    
    private func setupNameLabel(name: String) {
        nameLabel = UILabel()
        container.addArrangedSubview(nameLabel)
        nameLabel.text = name
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
    }
    
    private func setupSettingSegment(segmentNames: [String]) {
        settingSegment = UISegmentedControl(items: segmentNames)
        settingSegment.translatesAutoresizingMaskIntoConstraints = false
        container.addArrangedSubview(settingSegment)
        settingSegment.backgroundColor = #colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)
        settingSegment.selectedSegmentTintColor = .white
        settingSegment.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
        settingSegment.selectedSegmentIndex = UserDefaults.standard.integer(forKey: nameSetting)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leftAnchor.constraint(equalTo: leftAnchor),
            container.rightAnchor.constraint(equalTo: rightAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            settingSegment.widthAnchor.constraint(equalToConstant: 115),
            settingSegment.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func segmentValueChanged(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: nameSetting)
    }
}
