//
//  OnboardingPresenter.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 10.08.2022.
//

import Foundation

protocol OnboardingPresenterProtocol {
    var numberOfPages: Int { get }

    func getPagesViewModel(for index: IndexPath) -> OnboardingPage
}

class OnboardingPresenter: OnboardingPresenterProtocol {

    // MARK: - Properties

    let pagesViewModel = [
        OnboardingPage(
            image: .rocket,
            headerText: "Boost Productivity",
            descriptionText: "Take your productivity to the next level"
        ),
        OnboardingPage(
            image: .laptop,
            headerText: "Work Seamlessly",
            descriptionText: "Get your work done seamlessly \nwithout interruption"
        ),
        OnboardingPage(
            image: .girl,
            headerText: "Achieve Your Goals",
            descriptionText: "Boosted productivity will help you achieve \nthe desired goals"
        )
    ]

    var numberOfPages: Int {
        return pagesViewModel.count
    }

    // MARK: - Methods

    func getPagesViewModel(for index: IndexPath) -> OnboardingPage {
        guard index.isInRange(of: numberOfPages) else {
            return .defaultPage
        }
        return pagesViewModel[index.row]
    }
}
