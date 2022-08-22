//
//  InitialController.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 09.08.2022.
//

import UIKit

class InitialController: UIViewController {

    // MARK: - Properties

    var mainCoordinator: InitialFlowCoordinator!

    // MARK: - UI Elements

    private lazy var startButton: PrimaryButton = {
        let button = PrimaryButton(title: "Start", state: .enabled)
        button.addTarget(self, action: #selector(startButtonDidTap), for: .touchUpInside)
        return button
    }()

    // MARK: - Actions

    @objc private func startButtonDidTap() {
        startButton.buttonState = .disabled
        mainCoordinator.presentOnboardingScreen()
    }

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureUIElements()
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