//
//  UIViewController+Ext.swift
//  RocketApp
//
//  Created by Кирилл on 08.01.2023.
//

import UIKit

extension UIViewController {
    func presentError(error: Error) {
        let alertController = UIAlertController(title: "Ошибка",
                                                message: String(describing: error),
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
