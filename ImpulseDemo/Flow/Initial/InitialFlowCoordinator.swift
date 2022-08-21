//
//  InitialFlowCoordinator.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 21.08.2022.
//

import UIKit

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
        let viewModel: InitialViewModelProtocol = InitialViewModel(coordinator: self)
        let initialController = InitialController(viewModel: viewModel)
        return initialController
    }

}
