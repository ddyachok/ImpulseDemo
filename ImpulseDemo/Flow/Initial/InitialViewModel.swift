//
//  InitialViewModel.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 21.08.2022.
//

import RxSwift
import RxCocoa

protocol InitialViewModelProtocol: AnyObject {

}

final class InitialViewModel: InitialViewModelProtocol, DisposeBagProtocol {

    // MARK: - Properties

    var coordinator: InitialFlowCoordinator

    // MARK: - Initializers

    init(coordinator: InitialFlowCoordinator) {
        self.coordinator = coordinator
    }

}
