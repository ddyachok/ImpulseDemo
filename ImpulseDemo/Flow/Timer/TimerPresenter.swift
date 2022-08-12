//
//  TimerPresenter.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 11.08.2022.
//

import Foundation

protocol TimerPresenterProtocol {
    var controller: (AlertProtocol & TimerControllerProtocol)? { get set }

    func startTimer()
}

class TimerPresenter: TimerPresenterProtocol {

    // MARK: - Properties

    weak var controller: (AlertProtocol & TimerControllerProtocol)?
    private let userDefaults = UserDefaults.standard
    var totalTime: Float = 0.0
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

    // MARK: - Actions

    @objc func updateTimer() {
        guard totalTime == Constants.Timer.numberOfSeondsInMinute else {
            totalTime.increment()
            controller?.updateTimer(
                with: totalTime.convertToTime(),
                progressValue: totalTime / Constants.Timer.numberOfSeondsInMinute
            )
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
        stopShowingTimerScreen()
        controller?.setContinueButton(state: .enabled)
    }

    func stopShowingTimerScreen() {
        userDefaults.set(true, forKey: UserDefaultsKeys.timerScreenWasShown)
    }
}
