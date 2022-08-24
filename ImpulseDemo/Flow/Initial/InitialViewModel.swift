//
//  InitialViewModel.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 24.08.2022.
//

import UIKit
import RxSwift
import RxCocoa

protocol InitialViewModelProtocol: AnyObject {
    var didTapStartButton: PublishSubject<Void> { get }
}

final class InitialViewModel: InitialViewModelProtocol, DisposeBagProtocol {

    // MARK: - Properties

    var coordinator: InitialFlowCoordinator!

    var pages = BehaviorRelay<[OnboardingPage]>(value: OnboardingPage.allPages)
    var didTapStartButton = PublishSubject<Void>()

    // MARK: - Initializers

    convenience init(coordinator: InitialFlowCoordinator) {
        self.init()
        self.coordinator = coordinator
        setupBindings()
    }

    // MARK: - Methods


    // MARK: - Binding Methods

    private func setupBindings() {
        bindDidTapStartButton()
    }

    private func bindDidTapStartButton() {
        didTapStartButton
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                self.coordinator.presentOnboardingScreen(pages: self.pages)
            })
            .disposed(by: disposeBag)
    }
}
