//
//  UIImage+Asset.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 12.08.2022.
//

import UIKit

extension UIImage {
    convenience init?(named: ImageAsset) {
        self.init(named: named.assetName)
    }
}
