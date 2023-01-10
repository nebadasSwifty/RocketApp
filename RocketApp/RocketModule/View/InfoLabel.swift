//
//  InfoLabel.swift
//  RocketApp
//
//  Created by Кирилл on 04.01.2023.
//

import UIKit

final class InfoLabel: UIView {
    private var container: UIStackView!
    private var nameLabel: UILabel!
    private var valueLabel: UILabel!
    
    init(name: String, value: String? = nil, attributedValue: NSAttributedString? = nil) {
        super.init(frame: .zero)
        setupView(name: name, value: value, attributedValue: attributedValue)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(name: String, value: String? = nil, attributedValue: NSAttributedString? = nil) {
        setupContainer()
        setupNameLabel(name: name)
        setupValueLabel(value: value, attributedValue: attributedValue)
        setupLayout()
    }
    
    private func setupContainer() {
        container = UIStackView(frame: .zero)
        container.axis = .horizontal
        container.distribution = .fill
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)
    }
    
    private func setupNameLabel(name: String) {
        nameLabel = UILabel()
        container.addArrangedSubview(nameLabel)
        nameLabel.text = name
        nameLabel.textAlignment = .left
        nameLabel.textColor = .gray
    }
    
    private func setupValueLabel(value: String? = nil, attributedValue: NSAttributedString? = nil) {
        valueLabel = UILabel()
        container.addArrangedSubview(valueLabel)
        valueLabel.textColor = .white
        valueLabel.textAlignment = .right
        
        if value != nil {
            valueLabel.text = value
        } else {
            valueLabel.attributedText = attributedValue
        }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leftAnchor.constraint(equalTo: leftAnchor),
            container.rightAnchor.constraint(equalTo: rightAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
