//
//  CoreDataManager.swift
//  Art4All
//
//  Created by Pedro Henrique Guedes Silveira on 09/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {

    public static let shared: CoreDataManager = CoreDataManager()

    private init() {

    }

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Art4All")

        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("Could not retrieve a persistent store description.")
        }

        container.loadPersistentStores { (_, error) in

            if let error = error as NSError? {
                print("Unresolved error \(String(describing: error)), \(String(describing: error.userInfo))")
            }
        }
        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
