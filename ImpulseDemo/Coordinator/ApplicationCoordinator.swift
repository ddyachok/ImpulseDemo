//
//  ApplicationCoordinator.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 21.08.2022.
//

import UIKit

enum RootFlow {
    case main
}

enum LaunchInstructor {
    static func setup() -> RootFlow {
        return .main
    }
}

protocol CoordinatorProtocol: AnyObject {
    func start()
}

final class ApplicationCoordinator: BaseCoordinator {

    // MARK: - Properties

    private let window: UIWindow
    private var presentedFlow: RootFlow = LaunchInstructor.setup()

    // MARK: - Initializers

    init(window: UIWindow) {
        self.window = window
    }

    // MARK: - Methods

    private func setRootViewController(_ viewController: UIViewController) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }

    private func setRootViewController(
        _ viewController: UIViewController,
        with animation: UIView.AnimationOptions = .transitionCurlUp,
        animationDuration: TimeInterval = 0.7
    ) {
        window.rootViewController = viewController
        UIView.transition(with: window, duration: animationDuration, options: animation, animations: nil, completion: nil)
    }

    private func presentMainFlow() {
        let flow = InitialFlowCoordinator(UINavigationController())
        presentedFlow = .main
        flow.finishFlow = { [weak self] in
            self?.removeDependency(flow)
            self?.presentedFlow = .main
            self?.start()
        }
        addDependency(flow)
        setRootViewController(flow.createFlow())
    }
}

// MARK: - Coordinatable

extension ApplicationCoordinator: CoordinatorProtocol {
    func resetFlow() {
        presentedFlow = LaunchInstructor.setup()
    }

    func start() {
        switch presentedFlow {
        case .main:
            presentMainFlow()
        }
    }
}
