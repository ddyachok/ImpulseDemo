//
//  FontType.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 09.08.2022.
//

enum FontType {
    case bold, semibold, regular

    var weight: String {
        switch self {
        case .bold:
            return "Inter-Bold"
        case .semibold:
            return "Inter-SemiBold"
        case .regular:
            return "Inter-Regular"
        }
    }
}
