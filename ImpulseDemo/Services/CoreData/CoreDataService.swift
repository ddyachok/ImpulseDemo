//
//  CoreDataService.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 24.08.2022.
//

import Foundation
import CoreData
import RxSwift
import UIKit

final class CoreDataService {

    private var persistentService = PersistentService.shared

    func addTimerSettings(with id: Int, timerWasShown: Bool) -> Observable<Void> {
        let newTimerSettings = TimerSettings(context: persistentService.context)
        newTimerSettings.id = Int32(id)
        newTimerSettings.timerWasShown = timerWasShown
        return persistentService.save()
    }

    func fetchTimerSettings(by id: Int) -> TimerSettings? {
        let predicate = NSPredicate(format: "id == %ld", id)
        return persistentService.fetch(TimerSettings.self, predicate: predicate).first
    }

    func deleteTimerSettings(_ timerSettings: TimerSettings) -> Observable<Void> {
        persistentService.delete(timerSettings)
        return persistentService.save()
    }
}
