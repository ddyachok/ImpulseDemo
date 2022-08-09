//
//  UIImageResources.swift
//  MIT
//
//  Created by Vladyslav Savonik on 22.02.2022.
//

import UIKit

enum ImagesAssets {
    case rocket
    case laptop
    case girl
    
    var assetName: String {
        switch self {
        case .rocket:
            return "rocket"
        case .laptop:
            return "laptop"
        case .girl:
            return "girl"
        }
    }

    var image: UIImage? {
        return UIImage(named: assetName)
    }
}

extension UIImage {
    convenience init?(named: ImagesAssets) {
        self.init(named: named.assetName)
    }
}

extension UIImageView {
    func set(image picture: ImagesAssets?) {
        image = picture?.image
    }
}
