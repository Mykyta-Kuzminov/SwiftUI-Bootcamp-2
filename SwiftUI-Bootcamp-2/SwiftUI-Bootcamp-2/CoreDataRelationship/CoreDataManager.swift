//
//  CoreDataManager.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 21.11.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static var instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataRelationship")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Loading error: \(error.localizedDescription)")
            }
        }
        context = container.viewContext
    }
    
    func saveData() {
        do {
            try context.save()
        } catch let error {
            print("Saving error: \(error.localizedDescription)")
        }
    }
}
