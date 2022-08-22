//
//  OnboardingFlowCoordinator.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 22.08.2022.
//

import UIKit
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
        let viewModel: OnboardingViewModelProtocol = OnboardingViewModel(coordinator: self, pages: self.pages)
        let controller = OnboardingController(viewModel: viewModel)
        controller.modalPresentationStyle = .fullScreen
        return controller
    }
}
