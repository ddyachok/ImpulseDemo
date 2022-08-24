//
//  Int+Range.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 24.08.2022.
//

import Foundation

extension Int {
    func isInRange(of number: Int) -> Bool {
        self >= 0 && (self..<number).contains(self)
    }
}
