//
//  HeaderBar.swift
//  RocketApp
//
//  Created by Кирилл on 09.01.2023.
//

import UIKit

final class HeaderBar: UIView {
    private var nameLabel: UILabel!
    private var closeButton: UIButton!
    private var closeButtonAction: (() -> Void)?

    init(closeButtonAction: (() -> Void)? = nil) {
        self.closeButtonAction = closeButtonAction
        super.init(frame: .zero)
        setupNameLabel()
        setupCloseButton()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        nameLabel.text = "Настройки"
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
    }

    private func setupCloseButton() {
        closeButton = UIButton(type: .system)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(closeButton)
        closeButton.setTitle("Закрыть", for: .normal)
        closeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        closeButton.backgroundColor = .black
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonIsTapped), for: .touchUpInside)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            closeButton.topAnchor.constraint(equalTo: topAnchor),
            closeButton.rightAnchor.constraint(equalTo: rightAnchor),
            closeButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    @objc private func closeButtonIsTapped() {
        closeButtonAction?()
    }
}
