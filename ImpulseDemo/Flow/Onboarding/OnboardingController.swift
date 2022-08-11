//
//  OnboardingController.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 09.08.2022.
//

import UIKit

class OnboardingController: UIViewController {

    // MARK: - Properties

    private var presenter: OnboardingPresenterProtocol

    // MARK: - UI Elements

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = presenter.numberOfPages
        pageControl.currentPageIndicatorTintColor = UIColor(.contentPrimary)
        pageControl.pageIndicatorTintColor = UIColor(.pageControlTint)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    private lazy var pagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: 416)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cell: OnboardingPageCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor(.backgroundPrimary)
        return collectionView
    }()

    private let bottomButton: PrimaryButton = {
        let button = PrimaryButton(title: "Next")
        button.addTarget(self, action: #selector(presentTimerScreen), for: .touchUpInside)
        return button
    }()

    // MARK: - Actions

    @objc private func nextButtonTapped() {
        let nextIndex = min(pageControl.currentPage + 1, presenter.numberOfPages - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        pagesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    @objc private func presentTimerScreen() {
        let timerController = TimerController()
        timerController.modalPresentationStyle = .overCurrentContext
        timerController.modalTransitionStyle = .crossDissolve
        navigationController?.present(timerController, animated: true, completion: nil)
    }

    // MARK: - Initializers

    init(presenter: OnboardingPresenterProtocol) {
        self.presenter = presenter
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
    }

    // MARK: - Configuration Methods

    private func configureView() {
        view.backgroundColor = UIColor(.backgroundPrimary)
    }

    private func configureUIElements() {
        configureBottomButton()
        configurePageControl()
        configurePagesCollectionView()
    }

    private func configureBottomButton() {
        view.addSubview(bottomButton)
        bottomButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -58).isActive = true
        bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        bottomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
    }

    private func configurePageControl() {
        view.addSubview(pageControl)
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: bottomButton.topAnchor, constant: -28).isActive = true
    }

    private func configurePagesCollectionView() {
        view.addSubview(pagesCollectionView)
        pagesCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pagesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pagesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pagesCollectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor).isActive = true
    }
}

// MARK: - UICollectionView

extension OnboardingController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfPages
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: OnboardingPageCollectionViewCell.reuseID,
            for: indexPath
        ) as? OnboardingPageCollectionViewCell  else {
            return UICollectionViewCell()
        }

        let page = presenter.getPagesViewModel(for: indexPath)
        cell.setup(with: page)
        return cell
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let collectionViewWidth = pagesCollectionView.contentSize.width - scrollView.frame.size.width
        let didReachEnd = offsetX > (collectionViewWidth - view.frame.width)

        // TODO: - make this shit work
        guard didReachEnd else {
            bottomButton.setTitle("Next", for: .normal)
            bottomButton.addTarget(bottomButton, action: #selector(nextButtonTapped), for: .touchUpInside)
            bottomButton.removeTarget(bottomButton, action: #selector(presentTimerScreen), for: .touchUpInside)
            return
        }

        bottomButton.setTitle("Continue", for: .normal)
        bottomButton.addTarget(bottomButton, action: #selector(presentTimerScreen), for: .touchUpInside)
        bottomButton.removeTarget(bottomButton, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
}
