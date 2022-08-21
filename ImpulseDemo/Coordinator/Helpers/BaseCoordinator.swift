//
//  BaseCoordinator.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 21.08.2022.
//

import Foundation

open class BaseCoordinator {

    // MARK: - Parameters

    var childCoordinators: [FlowCoordinatorProtocol] = []

    // MARK: - Methods

    func addDependency(_ coordinator: FlowCoordinatorProtocol) {
        for element in childCoordinators {
            if element === coordinator {
                return
            }
        }

        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: FlowCoordinatorProtocol?) {
        guard childCoordinators.isEmpty == false, let coordinator = coordinator else {
            return
        }

        for (index, element) in childCoordinators.enumerated() {
            guard element === coordinator else {
                return
            }

            childCoordinators.remove(at: index)
        }
    }
}
