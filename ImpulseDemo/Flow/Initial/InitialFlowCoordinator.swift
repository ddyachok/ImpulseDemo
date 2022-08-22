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
        let initialController = InitialController()
        let navigationViewController = UINavigationController(rootViewController: initialController)
        containerViewController = navigationViewController
        initialController.mainCoordinator = self
        return navigationViewController

    }

    func presentOnboardingScreen() {
        let onboardingCoordinator = OnboardingFlowCoordinator(containerViewController)
        navigationController?.present(onboardingCoordinator.createFlow(), animated: true, completion: nil)
    }
}
