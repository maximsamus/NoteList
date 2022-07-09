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
        let container = NSPersistentContainer(name: "JustDoIt")
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
