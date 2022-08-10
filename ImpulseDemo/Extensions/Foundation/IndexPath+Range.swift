//
//  IndexPath+Range.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 10.08.2022.
//

import Foundation

extension IndexPath {
    func isInRange(of number: Int) -> Bool {
        (row ..< number).contains(row)
    }
}
