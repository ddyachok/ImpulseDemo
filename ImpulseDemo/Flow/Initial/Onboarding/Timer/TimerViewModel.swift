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
    var totalTime: BehaviorRelay<Float> { get set }
    var shouldTimerBeStopped: BehaviorRelay<Bool> { get set }

    var didTapContinueButton: PublishSubject<Void> { get }

    func startTimer()
}

final class TimerViewModel: TimerViewModelProtocol, DisposeBagProtocol {

    // MARK: - Properties

    var coordinator: OnboardingFlowCoordinator!
    private let userDefaults = UserDefaults.standard
    private lazy var timer: Timer = {
        let timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
        return timer
    }()

    var totalTime = BehaviorRelay<Float>(value: 0.0)
    var shouldTimerBeStopped = BehaviorRelay<Bool>(value: false)

    var didTapContinueButton = PublishSubject<Void>()

    // MARK: - Initializers

    convenience init(coordinator: OnboardingFlowCoordinator, pages: BehaviorRelay<[OnboardingPage]>) {
        self.init()
        self.coordinator = coordinator
        setupBindings()
    }

    // MARK: - Actions

    @objc func updateTimer() {
        guard totalTime.value == Constants.Timer.numberOfSeondsInMinute else {
            totalTime.accept(totalTime.value + 1)
            return
        }
        stopTimer()
    }

    // MARK: - Methods

    func startTimer() {
        timer.fire()
    }

    private func stopTimer() {
        timer.invalidate()
        shouldTimerBeStopped.accept(true)
        stopShowingTimerScreen()
    }

    func stopShowingTimerScreen() {
        userDefaults.set(true, forKey: UserDefaultsKeys.timerScreenWasShown)
    }

    // MARK: - Binding Methods

    private func setupBindings() {
        bindDidTapContinueButton()
    }

    private func bindDidTapContinueButton() {
        didTapContinueButton
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                guard self.shouldTimerBeStopped.value else {
                    return
                }
                self.coordinator.dismissPresentedViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
