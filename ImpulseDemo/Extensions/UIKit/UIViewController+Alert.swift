//
//  UIViewController+Alert.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 11.08.2022.
//

import UIKit

extension UIViewController: AlertProtocol {
    func present(alert type: AlertType) {
        let alert = UIAlertController(title: type.title, message: type.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    func presentAlertAction(ofType type: AlertType, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: type.title, message: type.message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
}
