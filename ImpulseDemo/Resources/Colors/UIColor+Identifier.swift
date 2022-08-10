//
//  UIColor+Identifier.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 09.08.2022.
//

import UIKit

enum ColorIdentifier: String {
    case backgroundPrimary = "backgroundPrimary"
    case backgroundSecondary = "backgroundSecondary"
    case contentAccent = "contentAccent"
    case contentPrimary = "contentPrimary"
    case pageControlTint = "pageControlTint"
}

extension UIColor {
    convenience init!(_ colorIdentifier: ColorIdentifier) {
        self.init(named: colorIdentifier.rawValue)
    }
}
