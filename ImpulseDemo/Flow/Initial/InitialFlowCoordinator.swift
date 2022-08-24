//
//  InitialFlowCoordinator.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 21.08.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class InitialFlowCoordinator: BaseCoordinator, FlowCoordinatorProtocol {

    // MARK: - Properties

    var containerViewController: UIViewController?
    var finishFlow: (() -> Void)?

    // MARK: - Constructor

    init(_ containerViewController: UIViewController?) {
        super.init()
        self.containerViewController = containerViewController
    }

    func createFlow() -> UIViewController {
        let viewModel = InitialViewModel(coordinator: self)
        let initialController = InitialController(viewModel: viewModel)
        let navigationViewController = UINavigationController(rootViewController: initialController)
        containerViewController = navigationViewController
        return navigationViewController

    }

    func presentOnboardingScreen(pages: BehaviorRelay<[OnboardingPage]>) {
        let flowCoordinator = OnboardingFlowCoordinator(containerViewController)
        let controller = flowCoordinator.createFlow()
        controller.modalPresentationStyle = .fullScreen
        containerViewController?.present(controller, animated: true, completion: nil)
    }
}
