//
//  TimerViewModel.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 24.08.2022.
//

import UIKit
import RxSwift
import RxCocoa

protocol TimerViewModelProtocol: AnyObject {

}

final class TimerViewModel: TimerViewModelProtocol, DisposeBagProtocol {

    // MARK: - Properties

    var coordinator: OnboardingFlowCoordinator!

    // MARK: - Initializers

    convenience init(coordinator: OnboardingFlowCoordinator) {
        self.init()
        self.coordinator = coordinator
        setupBindings()
    }

    // MARK: - Methods


    // MARK: - Binding Methods

    private func setupBindings() {

    }
}
