//
//  OnboardingFlowCoordinator.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 24.08.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class OnboardingFlowCoordinator: BaseCoordinator, FlowCoordinatorProtocol {

    // MARK: - Properties

    var containerViewController: UIViewController?
    var finishFlow: (() -> Void)?

    var pages = BehaviorRelay<[OnboardingPage]>(value: OnboardingPage.allPages)

    // MARK: - Constructor

    init(_ containerViewController: UIViewController?) {
        super.init()
        self.containerViewController = containerViewController
    }

    func createFlow() -> UIViewController {
        let viewModel = OnboardingViewModel(coordinator: self, pages: pages)
        let controller = OnboardingController(viewModel: viewModel)
        let navigationViewController = UINavigationController(rootViewController: controller)
        containerViewController = navigationViewController

        return navigationViewController
    }

    func presentTimerScreen() {
        let viewModel = TimerViewModel(coordinator: self, pages: pages)
        let controller = TimerController(viewModel: viewModel)
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        containerViewController?.present(controller, animated: true)
    }
}
