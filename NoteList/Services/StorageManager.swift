//
//  StorageManager.swift
//  NoteList
//
//  Created by Максим Самусь on 09.07.2022.
//

import CoreData

class StorageManager {
    static let shared = StorageManager()
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NoteList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private init() {}
    
    func fetchedResultsController(entityName: String, keysForSort: [String]) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var sortDescriptors: [NSSortDescriptor] = []
        keysForSort.forEach { keyForSort in
            let sortDescriptor = NSSortDescriptor(key: keyForSort, ascending: true)
            sortDescriptors.append(sortDescriptor)
        }
        fetchRequest.sortDescriptors = sortDescriptors
        
        let fetchResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        return fetchResultsController
    }
    
    func saveTask(withTitle title: String, andPriority priority: Int16) {
        let task = Task(context: viewContext)
        task.title = title
        task.priority = priority
        task.date = Date()
        task.isComplete = false
        saveContext()
    }
    
    func edit(task: Task, with newTitle: String, and priority: Int16) {
        task.title = newTitle
        task.priority = priority
        saveContext()
    }
    
    func done(task: Task) {
        task.isComplete.toggle()
        saveContext()
    }
    
    func delete(task: Task) {
        viewContext.delete(task)
        saveContext()
    }
    
    // MARK: - Core Data Saving support
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
