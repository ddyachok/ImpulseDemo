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
        childCoordinators.forEach { element in
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

        childCoordinators.enumerated().forEach { index, element in
            guard element === coordinator else {
                return
            }
            childCoordinators.remove(at: index)
        }
    }
}
