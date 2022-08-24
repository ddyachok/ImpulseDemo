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
    var shouldTimerScreenBeDisplayed: BehaviorRelay<Bool> { get }
    var currentPageNumber: BehaviorRelay<Int> { get set }

    var pageDidChange: PublishRelay<Int> { get set }
    var pageControlValueDidChange: PublishRelay<Int> { get set }

    var didTapBottomButton: PublishSubject<Void> { get }
    var didScrollPagesCollectionView: PublishSubject<Void> { get }

    func getPage(for index: IndexPath) -> OnboardingPage
}

final class OnboardingViewModel: OnboardingViewModelProtocol, DisposeBagProtocol {

    // MARK: - Properties

    var coordinator: OnboardingFlowCoordinator!
    private let userDefaults = UserDefaults.standard

    var pages = BehaviorRelay<[OnboardingPage]>(value: [])
    var didReachLastPage = BehaviorRelay<Bool>(value: false)
    var shouldTimerScreenBeDisplayed = BehaviorRelay<Bool>(value: false)
    var currentPageNumber = BehaviorRelay<Int>(value: 0)

    var pageDidChange = PublishRelay<Int>()
    var pageControlValueDidChange = PublishRelay<Int>()

    var didTapBottomButton = PublishSubject<Void>()
    var didScrollPagesCollectionView = PublishSubject<Void>()

    // MARK: - Initializers

    convenience init(coordinator: OnboardingFlowCoordinator, pages: BehaviorRelay<[OnboardingPage]>) {
        self.init()
        self.coordinator = coordinator
        self.pages = pages
        setupBindings()
    }

    // MARK: - Methods

    private func addActionToBottomButton() {
        guard currentPageNumber.value.isInRange(of: pages.value.count - 1) else {
            coordinator.presentTimerScreen()
            return
        }
        currentPageNumber.accept((currentPageNumber.value) + 1)
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

    // MARK: - Binding Methods

    private func setupBindings() {
        bindDidTapBottomButton()
        bindPageDidChange()
        bindPageControlValueDidChange()
//        bindDidReachLastPage()
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
