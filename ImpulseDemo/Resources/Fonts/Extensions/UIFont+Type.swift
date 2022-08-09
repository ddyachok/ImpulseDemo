//
//  UIFont+Type.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 09.08.2022.
//

import UIKit

extension UIFont {
    convenience init?(name type: FontType, size fontSize: CGFloat) {
        self.init(name: type.weight, size: fontSize)
    }
}
