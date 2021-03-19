//
//  CoreDataController.swift
//  Noty
//
//  Created by Youssef Jdidi on 12/3/2021.
//

import Foundation
import CoreData

typealias RequestLocalCompletion<T> = (Result<Storable?, Error>) -> Void
typealias ArrayLocalCompletion<T> = (Result<[Storable?], Error>) -> Void

protocol CoreDataControllerProtocol {

    /// Main/view context
    var viewContext: NSManagedObjectContext { get }

    /// Private/Background context
    var backgroundContext: NSManagedObjectContext { get }

    /// Deletes objects in a background context
    /// based on the entity name and the predicate provided
    func delete(entityName: String, predicate: NSPredicate?)

    /// Fetched the database managed object in the provided context
    /// Parameters:
    /// - entityName: the name in the xcdatamodel
    /// - predicate: NSPredicate to narrow the fetched results, if needed
    /// - context: main/view context) for ui related work, private/background for the rest
    func fetch(entityName: String, predicate: NSPredicate?, context: NSManagedObjectContext, _ completion: @escaping ArrayLocalCompletion<[NSManagedObject]>)

    /// Saves changes on the provided context - background or view context -, if there are any
    func saveIfNeeded(_ context: NSManagedObjectContext, _ completion: @escaping (Result<Void, Error>) -> Void)

    /// It execute what the name says 😏
    func getCount(entityName: String) -> Int
}

class CoreDataController: CoreDataControllerProtocol {

    // MARK: - Properties
    private var persistentContainer: NSPersistentContainer

    // NOTE: -
    // Core Data is not thread safe
    // -> it can cause weird errors and crashes
    // if different context are not handled properly
    // i.e. view context and background context
    var viewContext: NSManagedObjectContext

    // NOTE: -
    // a Computed Property is evaluated each time it is accessed
    // -> it creates a new instance every time it's accessed
    // Shoul keep in mind that to avoid
    // -> multithread violation - 🎖 All that's left to us is honor!! 🎖
    // That is the actual error core data throws, I kid you not! 😎
    var backgroundContext: NSManagedObjectContext {
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.name = "Background"
        privateContext.parent = persistentContainer.viewContext
        privateContext.automaticallyMergesChangesFromParent = true
        // in case of context merge conflicts
        // prefers the changes made to the objects in the context
        // instead of the state of the objects from the persistent store
        privateContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump

        return privateContext
    }

    // MARK: - Init
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
        viewContext = persistentContainer.viewContext

        load()
    }

    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { [weak self] _, error in
            guard let self = self else { return assertionFailure() }
            guard error == nil else { return assertionFailure(error!.localizedDescription) }
            // autosave()

            self.viewContext.automaticallyMergesChangesFromParent = true
            // in case of context merge conflicts
            // prefers the changes made to the objects in the context
            // instead of the state of the objects from the persistent store
            self.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            completion?()
        }
    }
}

// MARK: - Fetch
extension CoreDataController {

    func fetch(
        entityName: String,
        predicate: NSPredicate?,
        context: NSManagedObjectContext,
        _ completion: @escaping ArrayLocalCompletion<[NSManagedObject]>
    ) {
        let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
        if let predicate = predicate {
            request.predicate = predicate
        }

        if context.name == "Background" {
            context.performAndWait {
                do {
                    let response = try context.fetch(request)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            }
        } else {
            do {
                let response = try context.fetch(request)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Delete
extension CoreDataController {

    func delete(entityName: String, predicate: NSPredicate?) {
        let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
        request.predicate = predicate

        let context = backgroundContext

        context.performAndWait {
            do {
                let response = try context.fetch(request)
                response.forEach { context.delete($0) }
                try context.save()
                Console.log(type: .success, "Previously saved objects deleted - entity name: \(entityName) and predicate: \(String(describing: predicate))")
                try viewContext.save()
            } catch {
                assertionFailure()
            }
        }
    }
}

// MARK: - Get Count (just for id purpose) and is faster than fetching and getting the count
extension CoreDataController {
    func getCount(entityName: String) -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let count = try backgroundContext.count(for: fetchRequest)
            return count
        } catch {
            print(error.localizedDescription)
        }
        return 0
    }
}

// MARK: - Save
extension CoreDataController {

    func saveIfNeeded(
        _ context: NSManagedObjectContext,
        _ completion: @escaping (Result<Void, Error>) -> Void
    ) {

        // Background context
        if context.name == "Background" {
            context.performAndWait {
                do {
                    try context.save()

                    // after the changes on the background context are saved
                    // those changes are merged to view context automatically
                    // since the parent of the background context is set to view context
                    // and the automaticallyMergesChangesFromParent is set to true

                    // but after merging, the view context has unsaved changes
                    // and should also be saved
                    try viewContext.save()
                    completion(.success(()))
                } catch {
                    completion(.failure(error))
                }
            }
        } else {
            // view context
            guard context.hasChanges else { return }

            do {
                try viewContext.save()
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
