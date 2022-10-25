//
//  CoreDataManager.swift
//  NegroniChallenge
//
//  Created by Nicola Rigoni on 25/10/22.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading coredata: \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("Saved succesfully")
        } catch let error {
            print("Error saving coredata: \(error.localizedDescription)")
        }
        
    }
}
