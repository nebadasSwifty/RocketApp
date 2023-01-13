//
//  RocketView.swift
//  RocketApp
//
//  Created by Кирилл on 04.01.2023.
//

import UIKit

final class RocketView: UIView {
    private var scrollView: UIScrollView!
    private var rocketImageView: UIImageView!
    var container: UIStackView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        setupScrollView()
        setupImageView()
        setupContainer()
        setupLayout()
    }

    private func setupImageView() {
        rocketImageView = UIImageView()
        rocketImageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(rocketImageView)
        rocketImageView.contentMode = .scaleAspectFill
    }

    private func setupScrollView() {
        scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        addSubview(scrollView)
        scrollView.backgroundColor = .black
    }

    private func setupContainer() {
        container = UIStackView(frame: .zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(container)
        container.axis = .vertical
        container.distribution = .equalSpacing
        container.spacing = 20
        container.backgroundColor = .black
        container.layer.cornerRadius = 25
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = UIEdgeInsets(top: 48, left: 32, bottom: 8, right: 32)
        container.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            rocketImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            rocketImageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            rocketImageView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            rocketImageView.heightAnchor.constraint(equalToConstant: 320),
            container.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            container.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 290),
            container.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            container.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }

    func setupImageToView(data: Data? = nil, image: UIImage? = nil) {
        // swiftlint: disable line_length
        rocketImageView.image = data != nil ? UIImage(data: data!)?.downsample(reductionAmount: 0.6) : image?.downsample(reductionAmount: 0.6)
    }

    func addViewToContainer(view: UIView) {
        container.addArrangedSubview(view)
    }
}
