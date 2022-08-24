//
//  UIScrollView+LastPage.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 24.08.2022.
//

import UIKit

extension UIScrollView {
    func didReachLastPage(_ collectionView: UICollectionView, view: UIView) -> Bool {
        let offsetX = self.contentOffset.x
        let collectionViewWidth = collectionView.contentSize.width - self.frame.size.width
        let didReachLastPage = offsetX > (collectionViewWidth - view.frame.width / 1.6)
        return didReachLastPage
    }
}
