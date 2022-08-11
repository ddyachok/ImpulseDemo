//
//  PrimaryButton.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 09.08.2022.
//

import UIKit

final class PrimaryButton: UIButton {

    // MARK: - Properties

    var buttonState: ButtonState? {
        didSet {
            updateState(to: buttonState ?? .enabled)
        }
    }

    // MARK: - Initializers

    init(title: String, state: ButtonState = .enabled, type: UIButton.ButtonType = .system) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        updateState(to: state)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Methods

    private func updateState(to state: ButtonState) {
        switch state {
        case .enabled:
            alpha = 1
            isEnabled = true
        case .disabled:
            alpha = 0.4
            isEnabled = false
        }
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = UIColor(.contentAccent)
        setTitleColor(UIColor(.contentPrimary), for: .normal)
        titleLabel?.font = UIFont(type: .interSemibold, size: 16)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)

        UIView.animate(withDuration: 0.25) {
            self.transform = CGAffineTransform.identity
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }
}

