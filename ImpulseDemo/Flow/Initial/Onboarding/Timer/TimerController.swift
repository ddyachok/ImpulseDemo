//
//  TimerController.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 10.08.2022.
//

import UIKit

protocol TimerControllerProtocol {
    func updateTimer(with timeText: String, progressValue: Float)
    func setContinueButton(state: ButtonState)
}

class TimerController: UIViewController, TimerControllerProtocol {

    // MARK: - Properties

    private var viewModel: TimerViewModelProtocol

    // MARK: - UI Elements

    private lazy var cardView: UIView = {
        let cardViewWidth = view.bounds.width - 48
        let cardViewHeight = view.bounds.height / 2
        let xCenter = (view.bounds.width / 2) - (cardViewWidth / 2)
        let yCenter = cardViewHeight - (cardViewHeight / 2)
        let view = UIView(frame: CGRect(x: xCenter, y: yCenter, width: cardViewWidth, height: cardViewHeight))
        view.backgroundColor = UIColor(.backgroundSecondary)
        view.layer.cornerRadius = 28
        return view
    }()

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = UIColor(.contentPrimary)
        label.font = UIFont(type: .interSemibold, size: 68)
        label.textAlignment = .center
        return label
    }()

    private lazy var timeProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.setProgress(0, animated: false)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = UIColor(.contentAccent)
        progressView.tintColor = UIColor(.contentAccent)
        return progressView
    }()

    private lazy var continueButton: PrimaryButton = {
        let button = PrimaryButton(title: "Continue", state: .disabled)
        button.addTarget(self, action: #selector(closeTimerScreen), for: .touchUpInside)
        return button
    }()

    // MARK: - Actions

    @objc private func closeTimerScreen() {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Initializers

    init(viewModel: TimerViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
//        configurePresenter()
        configureView()
        configureUIElements()
    }

    func updateTimer(with timeText: String, progressValue: Float) {
        timeLabel.text = timeText
        UIView.animate(withDuration: 0.2) {
            self.timeProgressView.setProgress(progressValue, animated: true)
        }
    }

    func setContinueButton(state: ButtonState) {
        continueButton.buttonState = state
    }

    // MARK: - Configuration Methods

//    private func configurePresenter() {
//        presenter.controller = self
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
//            self.presenter.startTimer()
//        }
//    }

    private func configureView() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }

    private func configureUIElements() {
        configureCardView()
        configureTimeLabel()
        configureTimeProgressView()
        configureStartButton()
    }

    private func configureCardView() {
        view.addSubview(cardView)
    }

    private func configureTimeLabel() {
        cardView.addSubview(timeLabel)
        timeLabel.heightAnchor.constraint(equalToConstant: 78).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 28).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -28).isActive = true
        timeLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 96).isActive = true
    }

    private func configureTimeProgressView() {
        cardView.addSubview(timeProgressView)
        timeProgressView.heightAnchor.constraint(equalToConstant: 8).isActive = true
        timeProgressView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 28).isActive = true
        timeProgressView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -28).isActive = true
        timeProgressView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 32).isActive = true
    }

    private func configureStartButton() {
        cardView.addSubview(continueButton)
        continueButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        continueButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 32).isActive = true
        continueButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -32).isActive = true
        continueButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -32).isActive = true
    }
}

