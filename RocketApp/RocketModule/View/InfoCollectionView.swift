//
//  InfoCollectionView.swift
//  RocketApp
//
//  Created by Кирилл on 05.01.2023.
//

import UIKit

final class InfoCollectionView: UIView {
    var collectionView: UICollectionView!

    init(frame: CGRect, dataSource: UICollectionViewDataSource) {
        super.init(frame: frame)
        setupCollectionView(dataSource: dataSource)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadCollectionInfo),
                                               name: NSNotification.Name(rawValue: "reloadData"), object: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCollectionView(dataSource: UICollectionViewDataSource) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 96, height: 96)
        layout.scrollDirection = .horizontal

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = dataSource
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        collectionView.backgroundColor = .black
        collectionView.register(InfoCell.self, forCellWithReuseIdentifier: "InfoCell")
        collectionView.showsHorizontalScrollIndicator = false

        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            heightAnchor.constraint(equalToConstant: 96)
        ])
    }

    @objc private func reloadCollectionInfo() {
        collectionView.reloadData()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "reloadData"), object: nil)
    }
}
