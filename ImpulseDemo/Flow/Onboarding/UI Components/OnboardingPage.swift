//
//  OnboardingPage.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 10.08.2022.
//

import Foundation

struct OnboardingPage {
    let image: ImagesAssets
    let headerText: String
    let descriptionText: String
}

// MARK: - Mocks

extension OnboardingPage {
    static let defaultPage: Self = .init(
        image: .rocket,
        headerText: "Some Text",
        descriptionText: "Text text text text"
    )
}
