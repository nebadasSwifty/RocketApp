//
//  RocketView.swift
//  RocketApp
//
//  Created by Кирилл on 04.01.2023.
//

import UIKit

final class RocketView: UIView {
    private var scrollView: UIScrollView!
    private var container: UIStackView!
    private var rocketImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        setupImageView()
        setupScrollView()
        setupContainer()
    }
    
    private func setupImageView() {
        rocketImageView = UIImageView(frame: .zero)
        rocketImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rocketImageView)
                
        NSLayoutConstraint.activate([
            rocketImageView.topAnchor.constraint(equalTo: topAnchor),
            rocketImageView.leftAnchor.constraint(equalTo: leftAnchor),
            rocketImageView.rightAnchor.constraint(equalTo: rightAnchor),
            rocketImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(UIScreen.main.bounds.height / 2.5))
        ])
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: UIScreen.main.bounds.height / 2.5),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        
        scrollView.backgroundColor = .black
        scrollView.layer.cornerRadius = 25
        scrollView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    private func setupContainer() {
        container = UIStackView(frame: .zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(container)
        container.axis = .vertical
        container.distribution = .equalSpacing
        container.spacing = 20
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40),
            container.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 30),
            container.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: UIScreen.main.bounds.width - 30),
            container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    func setupImageToView(data: Data? = nil, image: UIImage? = nil) {
        rocketImageView.image = data != nil ? UIImage(data: data!) : image
    }
    
    func addViewToContainer(view: UIView) {
        container.addArrangedSubview(view)
    }
}
