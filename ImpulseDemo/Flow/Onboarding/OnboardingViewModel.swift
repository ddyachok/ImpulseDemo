//
//  OnboardingViewModel.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 22.08.2022.
//

import UIKit
import RxSwift
import RxCocoa

protocol OnboardingViewModelProtocol: AnyObject {
    var pages: BehaviorRelay<[OnboardingPage]> { get }
    var shouldTimerScreenBeDisplayed: BehaviorRelay<Bool> { get }

    func getPage(for index: IndexPath) -> OnboardingPage
}

final class OnboardingViewModel: OnboardingViewModelProtocol, DisposeBagProtocol {

    var coordinator: OnboardingFlowCoordinator!
    var pages = BehaviorRelay<[OnboardingPage]>(value: [])
    private let userDefaults = UserDefaults.standard
    var shouldTimerScreenBeDisplayed = BehaviorRelay<Bool>(value: true)

    // MARK: - Initializers

    convenience init(coordinator: OnboardingFlowCoordinator, pages: BehaviorRelay<[OnboardingPage]>) {
        self.init()
        self.coordinator = coordinator
        self.pages = pages
    }

    // MARK: - Methods

    private func setupTimer() {

    }

    private func checkTimerDisplayState() {
        shouldTimerScreenBeDisplayed.accept(!userDefaults.bool(forKey: UserDefaultsKeys.timerScreenWasShown))
    }

    func getPage(for index: IndexPath) -> OnboardingPage {
        guard index.isInRange(of: pages.value.count) else {
            return .defaultPage
        }
        return pages.value[index.row]
    }
}
