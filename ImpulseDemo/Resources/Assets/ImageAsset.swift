//
//  ImageAsset.swift
//  MIT
//
//  Created by Vladyslav Savonik on 22.02.2022.
//

import UIKit

enum ImageAsset {
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
