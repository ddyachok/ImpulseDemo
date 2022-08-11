//
//  TimerPresenter.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 11.08.2022.
//

import Foundation

protocol TimerPresenterProtocol {
    func stopShowingTimerScreen()
}

class TimerPresenter: TimerPresenterProtocol {

    // MARK: - Properties

    private let userDefaults = UserDefaults.standard


    // MARK: - Methods

    func stopShowingTimerScreen() {
        userDefaults.set(true, forKey: UserDefaultsKeys.timerScreenWasShown)
    }
}
