//
//  LaunchCell.swift
//  RocketApp
//
//  Created by Кирилл on 09.01.2023.
//

import UIKit

final class LaunchCell: UITableViewCell {
    private var nameLabel: UILabel!
    private var dateLabel: UILabel!
    private var statusImageView: UIImageView!
    private var infoBackgroundView: UIView!

    private func setupNameLabel(name: String) {
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        infoBackgroundView.addSubview(nameLabel)
        nameLabel.text = name
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 20)
    }

    private func setupDateLabel(dateValue: String) {
        dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        infoBackgroundView.addSubview(dateLabel)
        dateLabel.text = dateValue
        dateLabel.textColor = .gray
        dateLabel.font = UIFont.systemFont(ofSize: 16)
    }

    private func setupStatusImageView(status: Bool) {
        statusImageView = UIImageView(image: status ? UIImage(named: "successRocket") : UIImage(named: "failureRocket"))
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        infoBackgroundView.addSubview(statusImageView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            infoBackgroundView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            infoBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            infoBackgroundView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            infoBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            nameLabel.topAnchor.constraint(equalTo: infoBackgroundView.topAnchor, constant: 24),
            nameLabel.leftAnchor.constraint(equalTo: infoBackgroundView.leftAnchor, constant: 24),
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            dateLabel.leftAnchor.constraint(equalTo: infoBackgroundView.leftAnchor, constant: 24),
            dateLabel.bottomAnchor.constraint(equalTo: infoBackgroundView.bottomAnchor, constant: -24),
            statusImageView.leftAnchor.constraint(equalTo: nameLabel.rightAnchor),
            statusImageView.rightAnchor.constraint(equalTo: infoBackgroundView.rightAnchor, constant: -32),
            statusImageView.heightAnchor.constraint(equalToConstant: 32),
            statusImageView.widthAnchor.constraint(equalToConstant: 32),
            statusImageView.centerYAnchor.constraint(equalTo: infoBackgroundView.centerYAnchor)
        ])
    }

    private func setupBackgroundView() {
        infoBackgroundView = UIView()
        infoBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(infoBackgroundView)
        infoBackgroundView.backgroundColor = #colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)
        infoBackgroundView.layer.cornerRadius = 24
    }

    func configureCell(name: String, date: String, status: Bool) {
        selectionStyle = .none
        backgroundColor = .clear
        setupBackgroundView()
        setupNameLabel(name: name)
        setupDateLabel(dateValue: date)
        setupStatusImageView(status: status)
        setupLayout()
    }
}
