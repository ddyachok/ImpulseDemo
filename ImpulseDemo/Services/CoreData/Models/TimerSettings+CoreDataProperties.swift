//
//  TimerSettings+CoreDataProperties.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 24.08.2022.
//
//

import Foundation
import CoreData


extension TimerSettings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimerSettings> {
        return NSFetchRequest<TimerSettings>(entityName: "TimerSettings")
    }

    @NSManaged public var timerWasShown: Bool
    @NSManaged public var id: Int32

}

extension TimerSettings : Identifiable {

}
