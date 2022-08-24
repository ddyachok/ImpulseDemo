//
//  OnboardingPage.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 10.08.2022.
//

import Foundation

struct OnboardingPage {
    let image: ImageAsset
    let headerText: String
    let descriptionText: String
}

// MARK: - Pages with values

extension OnboardingPage {
    static let defaultPage: Self = .init(
        image: .rocket,
        headerText: "Some Text",
        descriptionText: "Text text text text"
    )

    static let firstPage: Self = OnboardingPage(
        image: .rocket,
        headerText: "Boost Productivity",
        descriptionText: "Take your productivity to the next level"
    )

    static let secondPage: Self = OnboardingPage(
        image: .laptop,
        headerText: "Work Seamlessly",
        descriptionText: "Get your work done seamlessly \nwithout interruption"
    )

    static let thirdPage: Self = OnboardingPage(
        image: .girl,
        headerText: "Achieve Your Goals",
        descriptionText: "Boosted productivity will help you achieve \nthe desired goals"
    )
    
    static let allPages: [Self] = [firstPage, secondPage, thirdPage].shuffled()
}
