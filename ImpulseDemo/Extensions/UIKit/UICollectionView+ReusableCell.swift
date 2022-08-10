//
//  UICollectionView+ReusableCell.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 10.08.2022.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(cell: T.Type) {
        register(cell, forCellWithReuseIdentifier: cell.reuseID)
    }
}
