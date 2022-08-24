//
//  OnboardingController.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 09.08.2022.
//

import UIKit
import RxSwift

class OnboardingController: UIViewController, DisposeBagProtocol {

    // MARK: - Properties

    private var viewModel: (OnboardingViewModelProtocol & OnboardingViewModelMethodsProtocol)

    // MARK: - UI Elements

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = viewModel.pages.value.count
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
        return button
    }()

    // MARK: - Initializers

    init(viewModel: (OnboardingViewModelProtocol & OnboardingViewModelMethodsProtocol)) {
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
        setupBindings()
    }

    // MARK: - Binding Methods

    private func setupBindings() {
        setupCurrentPageNumberBinding()
        setupDidReachLastPageBinding()
    }

    private func setupCurrentPageNumberBinding() {
        viewModel.currentPageNumber
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] page in
                self?.pageControl.currentPage = page
                self?.pagesCollectionView.scrollToItem(at: IndexPath(item: page, section: 0), at: .centeredHorizontally, animated: true)
            })
            .disposed(by: disposeBag)
    }

    private func setupDidReachLastPageBinding() {
        viewModel.didReachLastPage
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] didReach in
                self?.bottomButton.setTitle(didReach ? "Continue" : "Next", for: .normal)
            })
            .disposed(by: disposeBag)
    }

    private func bindToViewModel() {
        bindBottomButtonToViewModel()
        bindPageControlToViewModel()
        bindPagesCollectionViewToViewModel()
    }

    private func bindBottomButtonToViewModel() {
        bottomButton.rx.tap
            .bind(to: viewModel.didTapBottomButton)
            .disposed(by: disposeBag)
    }

    private func bindPageControlToViewModel() {
        pageControl.rx.controlEvent(.valueChanged)
            .map({ [weak self] in
                guard let currentPage = self?.pageControl.currentPage else {
                    return 0
                }
                return currentPage
            })
            .bind(to: viewModel.pageControlValueDidChange)
            .disposed(by: disposeBag)
    }

    private func bindPagesCollectionViewToViewModel() {
        pagesCollectionView.rx.willEndDragging
            .map({ [weak self] _, targetContentOffset in
                let x = targetContentOffset.pointee.x
                let pageNumber = Int(x / (self?.view.frame.width ?? 1.0))
                return pageNumber
            })
            .bind(to: viewModel.pageDidChange)
            .disposed(by: disposeBag)

        pagesCollectionView.rx.didScroll
            .map { [weak self] in
                guard let self = self else {
                    return false
                }
                return self.pagesCollectionView.didReachLastPage(self.pagesCollectionView, view: self.view)
            }
            .bind(to: viewModel.didReachLastPage)
            .disposed(by: disposeBag)
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
        return viewModel.pages.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: OnboardingPageCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(with: viewModel.getPage(for: indexPath))
        return cell
    }
}
