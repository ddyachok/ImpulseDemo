//
//  InitialController.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 09.08.2022.
//

import UIKit

class InitialController: UIViewController, DisposeBagProtocol {

    // MARK: - Properties

    private var viewModel: InitialViewModelProtocol

    // MARK: - UI Elements

    private lazy var startButton: PrimaryButton = {
        let button = PrimaryButton(title: "Start", state: .enabled)
        return button
    }()

//     MARK: - Actions
//
//    @objc private func startButtonDidTap() {
//        startButton.buttonState = .disabled
//        mainCoordinator.presentOnboardingScreen()
//    }

    // MARK: - Initializers

    init(viewModel: InitialViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureUIElements()
        bindToViewModel()
    }

    // MARK: - Binding Methods

    private func bindToViewModel() {
        bindStartButtonToViewModel()
    }

    private func bindStartButtonToViewModel() {
        startButton.rx.tap
            .bind(to: viewModel.didTapStartButton)
            .disposed(by: disposeBag)
    }

    // MARK: - Configuration Methods

    private func configureView() {
        view.backgroundColor = UIColor(.backgroundPrimary)
    }

    private func configureUIElements() {
        configureStartButton()
    }

    private func configureStartButton() {
        view.addSubview(startButton)
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 65).isActive = true
        startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -65).isActive = true
    }
}
