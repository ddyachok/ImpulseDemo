//
//  PrimaryButton.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 09.08.2022.
//

import UIKit

final class PrimaryButton: UIButton {

    // MARK: - Properties

    var buttonState: ButtonState = .enabled

    // MARK: - Initializers

    init(title: String, state: ButtonState = .enabled) {
        super.init(frame: .zero)
        self.buttonState = state
        setTitle(title, for: .normal)
        configure(dependingOn: state)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Methods

    private func configure(dependingOn state: ButtonState) {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = UIColor(.contentAccent)
        setTitleColor(UIColor(.contentPrimary), for: .normal)
        titleLabel?.font = UIFont(type: .interSemibold, size: 16)
        
        switch state {
        case .enabled:
            alpha = 1
        case .disabled:
            alpha = 0.4
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configure(dependingOn: buttonState)
    }
}

