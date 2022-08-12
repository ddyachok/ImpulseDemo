//
//  Float+Time.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 11.08.2022.
//

import Foundation

extension Float {
    func convertToTime() -> String {
        let seconds = Int(self.truncatingRemainder(dividingBy: Constants.Timer.numberOfSeondsInMinute))
        let minutes = Int((self / Constants.Timer.numberOfSeondsInMinute).truncatingRemainder(dividingBy: Constants.Timer.numberOfSeondsInMinute))
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
