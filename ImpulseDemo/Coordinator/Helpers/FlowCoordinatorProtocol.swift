//
//  FlowCoordinatorProtocol.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 21.08.2022.
//

import UIKit

@objc protocol FlowCoordinatorProtocol: AnyObject {
    var containerViewController: UIViewController? { get set }
    @objc optional var presentedContainerViewController: UIViewController? { get set }
    var finishFlow: (() -> Void)? { get set }

    @discardableResult
    func createFlow() -> UIViewController
}

extension FlowCoordinatorProtocol {

    // MARK: - Properties

    var navigationController: UINavigationController? {
        return containerViewController as? UINavigationController
    }

    var presentedNavigationController: UINavigationController? {
        return presentedContainerViewController as? UINavigationController
    }

    // MARK: - Methods

    func dismissPresentedViewController(animated: Bool) {
        guard presentedNavigationController == nil else {
            presentedNavigationController?.presentedViewController?.dismiss(animated: animated, completion: nil)
            return
        }
        containerViewController?.presentedViewController?.dismiss(animated: animated, completion: nil)
    }

    func dismissPresentedViewControllerFromParent(animated: Bool) {
        navigationController?.presentedViewController?.dismiss(animated: animated, completion: nil)
    }

    func popViewController(animated: Bool) {
        guard presentedNavigationController == nil else {
            presentedNavigationController?.popViewController(animated: animated)
            return
        }
        navigationController?.popViewController(animated: animated)
    }

    func popToRootViewController(animated: Bool) {
        guard presentedNavigationController == nil else {
            presentedNavigationController?.popToRootViewController(animated: true)
            return
        }
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - Alert

extension FlowCoordinatorProtocol {
    func present(alert type: AlertType) {
        navigationController?.present(alert: type)
    }
}
