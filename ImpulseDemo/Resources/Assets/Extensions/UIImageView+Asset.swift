//
//  UIImageView+Asset.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 12.08.2022.
//

import UIKit

extension UIImageView {
    func set(asset: ImageAsset?) {
        image = asset?.image
    }
}
