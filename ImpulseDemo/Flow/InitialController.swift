//
//  InitialController.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 09.08.2022.
//

import UIKit

class InitialController: UIViewController {

    // MARK: - Properties

    // MARK: - UI Elements

    private lazy var startButton: PrimaryButton = {
        let button = PrimaryButton(title: "Start", state: .enabled)
        button.addTarget(self, action: #selector(presentOnboardingScreen), for: .touchUpInside)
        return button
    }()

    // MARK: - Actions

    @objc private func presentOnboardingScreen() {
        let controller = OnboardingController()
        controller.modalPresentationStyle = .fullScreen
        navigationController?.present(controller, animated: true, completion: nil)
    }

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureStartButton()
    }

    // MARK: - Configuration Methods

    private func configureView() {
        view.backgroundColor = UIColor(.backgroundPrimary)
    }

    private func configureStartButton() {
        view.addSubview(startButton)
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 244).isActive = true
    }
}
