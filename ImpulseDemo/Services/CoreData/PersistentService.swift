//
//  PersistentService.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 24.08.2022.
//

import Foundation
import CoreData
import RxSwift

final class PersistentService {

    //MARK: - Properties

    static let shared = PersistentService()

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: Constants.CoreData.persistentContainerKitName)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var context = persistentContainer.viewContext

    // MARK: - Methods

    func save() -> Observable<Void> {
        Observable<Void>.create { observer -> Disposable in
            let context = self.persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                    observer.onNext(())
                } catch {
                    observer.onError(error)
                }
            }
            return Disposables.create {
                print("Deallocated")
            }
        }
    }

    func fetch<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate? = nil) -> [T] {
        let entityName: String = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = predicate

        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        }
        catch {
            return [T]()
        }
    }

    func delete(_ object: NSManagedObject) {
        context.delete(object)
        save()
    }
}
