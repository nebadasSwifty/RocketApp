//
//  LaunchesView.swift
//  RocketApp
//
//  Created by Кирилл on 08.01.2023.
//

import UIKit

final class LaunchesView: UIView {
    var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: bounds)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        tableView.backgroundColor = .black
        tableView.register(LaunchCell.self, forCellReuseIdentifier: "LaunchCell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
