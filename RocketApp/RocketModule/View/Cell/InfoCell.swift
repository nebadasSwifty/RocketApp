//
//  InfoCell.swift
//  RocketApp
//
//  Created by Кирилл on 09.01.2023.
//

import UIKit

final class InfoCell: UICollectionViewCell {
    private var nameLabel: UILabel!
    private var valueLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNameLabel()
        setupValueLabel()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        nameLabel.textColor = .gray
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
    private func setupValueLabel() {
        valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(valueLabel)
        valueLabel.textColor = .white
        valueLabel.textAlignment = .center
        valueLabel.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private func setupLayout() {
        backgroundColor = #colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)
        layer.cornerRadius = 32
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 96),
            heightAnchor.constraint(equalToConstant: 96),
            valueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 28),
            valueLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -28),
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func configure(name: String, value: String) {
        nameLabel.text = name
        valueLabel.text = value
    }
}
