//
//  CoreDataContextProvider.swift
//  Dota Heroes
//
//  Created by Tedjakusuma, Ferdinand on 06/05/23.
//  Copyright © 2023 Tiket.com. All rights reserved.
//

import CoreData

class CoreDataContextProvider {
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    private var persistentContainer: NSPersistentContainer
    init(completionClosure: ((Error?) -> Void)? = nil) {
        /// Create a persistent container
        persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            completionClosure?(error)
        }
    }

    func newBackgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }

    func saveContent() {
        if viewContext.hasChanges {
            do {
                UserDefaults.coreDataCreatedAt = Date()
                try viewContext.save()
            } catch {
                viewContext.rollback()
                let error = error as NSError
                fatalError("Unresolved error: \(error), \(error.userInfo)")
            }
        }
    }
}
