//
//  UICollectionViewCell+ReuseID.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 10.08.2022.
//

import UIKit

extension UICollectionViewCell {
    static var reuseID: String {
        return NSStringFromClass(self)
    }
}
