//
//  OnboardingPageCollectionViewCell.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 10.08.2022.
//

import UIKit

class OnboardingPageCollectionViewCell: UICollectionViewCell {

    // MARK: - UI Elements

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(
            x: 0,
            y: 0,
            width: contentView.frame.width,
            height: contentView.frame.height
        ))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(.contentPrimary)
        label.font = UIFont(type: .interBold, size: 28)
        label.textAlignment = .center
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(.contentPrimary)
        label.font = UIFont(type: .interRegular, size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    // MARK: - Initializers

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUIElements()
    }

    override func prepareForReuse() {
        configureUIElements()
    }

    func setup(with page: OnboardingPage) {
        imageView.set(asset: page.image)
        headerLabel.text = page.headerText
        descriptionLabel.text = page.descriptionText
    }

    // MARK: - Configuration Methods

    private func configureUIElements() {
        configureImageView()
        configureHeaderLabel()
        configureDescriptionLabel()
    }

    private func configureImageView() {
        contentView.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    }

    private func configureHeaderLabel() {
        contentView.addSubview(headerLabel)
        headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -28).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        headerLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40).isActive = true
    }

    private func configureDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -28).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 12).isActive = true
    }
}
