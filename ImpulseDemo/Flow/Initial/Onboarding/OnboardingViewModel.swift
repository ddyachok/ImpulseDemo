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
    var didReachLastPage: BehaviorRelay<Bool> { get }
    var currentPageNumber: BehaviorRelay<Int> { get set }

    var pageDidChange: PublishRelay<Int> { get set }
    var pageControlValueDidChange: PublishRelay<Int> { get set }
    var didTapBottomButton: PublishSubject<Void> { get }
}

protocol OnboardingViewModelMethodsProtocol: AnyObject {
    func getPage(for index: IndexPath) -> OnboardingPage
}

final class OnboardingViewModel: OnboardingViewModelProtocol, OnboardingViewModelMethodsProtocol, DisposeBagProtocol {

    // MARK: - Properties

    private var coordinator: OnboardingFlowCoordinator!
    private let coreDataService = CoreDataService()
    
    var shouldTimerScreenBeDisplayed: Bool {
        guard let timerSettings = coreDataService.fetchTimerSettings(by: Constants.Timer.defaultId) else {
            return true
        }
        return !timerSettings.timerWasShown
    }

    var pages = BehaviorRelay<[OnboardingPage]>(value: [])
    var didReachLastPage = BehaviorRelay<Bool>(value: false)
    var currentPageNumber = BehaviorRelay<Int>(value: 0)

    var pageDidChange = PublishRelay<Int>()
    var pageControlValueDidChange = PublishRelay<Int>()
    var didTapBottomButton = PublishSubject<Void>()

    // MARK: - Initializers

    convenience init(coordinator: OnboardingFlowCoordinator, pages: BehaviorRelay<[OnboardingPage]>) {
        self.init()
        self.coordinator = coordinator
        self.pages = pages
        setupBindings()
    }

    // MARK: - Methods

    private func addActionToBottomButton() {
        guard currentPageNumber.value.isInRange(of: pages.value.count) else {
            return
        }

        guard !didReachLastPage.value else {
            handleContinueButton()
            return
        }
        currentPageNumber.accept((currentPageNumber.value) + 1)
    }

    func handleContinueButton() {
        guard shouldTimerScreenBeDisplayed else {
            coordinator.present(alert: .functionalityUnderDevelopment)
            return
        }
        coordinator.presentTimerScreen()
    }

    func getPage(for index: IndexPath) -> OnboardingPage {
        guard index.isInRange(of: pages.value.count) else {
            return .defaultPage
        }
        return pages.value[index.row]
    }

    // MARK: - Binding Methods

    private func setupBindings() {
        bindDidTapBottomButton()
        bindPageDidChange()
        bindPageControlValueDidChange()
    }

    private func bindDidTapBottomButton() {
        didTapBottomButton
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                self.addActionToBottomButton()
            })
            .disposed(by: disposeBag)
    }

    private func bindPageDidChange() {
        pageDidChange
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.currentPageNumber.accept($0)
            })
            .disposed(by: disposeBag)
    }

    private func bindPageControlValueDidChange() {
        pageControlValueDidChange
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.currentPageNumber.accept($0)
            })
            .disposed(by: disposeBag)
    }
}
