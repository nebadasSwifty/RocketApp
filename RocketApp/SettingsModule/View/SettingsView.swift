//
//  SettingsView.swift
//  RocketApp
//
//  Created by Кирилл on 09.01.2023.
//

import UIKit

final class SettingsView: UIView {
    private var container: UIStackView!
    private var scrollView: UIScrollView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
        setupContainer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        
        scrollView.backgroundColor = .black
    }
    
    private func setupContainer() {
        container = UIStackView(frame: .zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(container)
        container.axis = .vertical
        container.distribution = .fillProportionally
        container.spacing = 20
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            container.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 40),
            container.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: UIScreen.main.bounds.width - 40),
            container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    func addViewToContainer(view: UIView) {
        container.addArrangedSubview(view)
    }
}
