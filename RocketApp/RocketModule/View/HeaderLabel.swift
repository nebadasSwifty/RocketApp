//
//  HeaderLabel.swift
//  RocketApp
//
//  Created by Кирилл on 04.01.2023.
//

import UIKit

final class HeaderLabel: UIView {
    private var container: UIStackView!
    private var headerNameLabel: UILabel!
    private var headerImageButton: UIButton!
    private var buttonAction: (() -> Void)?

    init(headerName: String, fontSize: CGFloat = 20, imageName: String? = nil, buttonAction: (() -> Void)? = nil) {
        self.buttonAction = buttonAction
        super.init(frame: .zero)
        setupContainer()
        setupLabel(name: headerName, fontSize: fontSize)

        if imageName != nil {
            setupButton(with: imageName!)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLabel(name: String, fontSize: CGFloat) {
        headerNameLabel = UILabel()
        container.addArrangedSubview(headerNameLabel)
        headerNameLabel.text = name
        headerNameLabel.textColor = .white
        headerNameLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
    }

    private func setupContainer() {
        container = UIStackView(frame: .zero)
        container.axis = .horizontal
        container.distribution = .fillProportionally
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leftAnchor.constraint(equalTo: leftAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }

    private func setupButton(with image: String) {
        headerImageButton = UIButton(frame: .zero)
        headerImageButton.setImage(UIImage(named: "Setting"), for: .normal)
        headerImageButton.tintColor = .white
        container.addArrangedSubview(headerImageButton)
        headerImageButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            headerImageButton.widthAnchor.constraint(equalToConstant: 32),
            headerImageButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    @objc private func buttonTapped() {
        buttonAction?()
    }
}
