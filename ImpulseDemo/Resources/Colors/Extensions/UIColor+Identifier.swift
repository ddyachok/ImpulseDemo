//
//  UIColor+Identifier.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 12.08.2022.
//

import UIKit

extension UIColor {
    convenience init!(_ colorIdentifier: ColorIdentifier) {
        self.init(named: colorIdentifier.rawValue)
    }
}
