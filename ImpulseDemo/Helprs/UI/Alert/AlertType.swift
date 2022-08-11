//
//  AlertController.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 11.08.2022.
//

import Foundation
import UIKit

protocol AlertProtocol: AnyObject {
    func present(alert type: AlertType)
}

enum AlertType {
    case timerUnavailable
}

extension AlertType {
    var title: String {
        switch self {
        case .timerUnavailable:
            return "Thank you for your interest"
        }
    }
    var message: String {
        switch self {
        case .timerUnavailable:
            return "The functionality is under development"
        }
    }
}
