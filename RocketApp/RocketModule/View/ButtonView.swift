//
//  ButtonView.swift
//  RocketApp
//
//  Created by Кирилл on 09.01.2023.
//

import UIKit

final class ButtonView: UIView {
    private var button: UIButton!
    private var buttonAction: (() -> ())?
    
    init(titleButton: String, buttonAction: (() -> ())? = nil) {
        super.init(frame: .zero)
        self.buttonAction = buttonAction
        setupButton(title: titleButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(title: String) {
        button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.setTitle(title, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 12
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leftAnchor.constraint(equalTo: leftAnchor),
            button.rightAnchor.constraint(equalTo: rightAnchor),
            heightAnchor.constraint(equalToConstant: 56),
            button.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    @objc private func buttonTapped() {
        buttonAction?()
    }
}
