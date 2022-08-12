//
//  FontType.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 09.08.2022.
//

enum FontType {
    case interBold
    case interSemibold
    case interRegular

    var weight: String {
        switch self {
        case .interBold:
            return "Inter-Bold"
        case .interSemibold:
            return "Inter-SemiBold"
        case .interRegular:
            return "Inter-Regular"
        }
    }
}
