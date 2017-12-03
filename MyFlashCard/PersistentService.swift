//
//  PersistentService.swift
//  MyFlashCard
//
//  Created by Suguru on 12/2/17.
//  Copyright © 2017 Suguru. All rights reserved.
//

import Foundation
import CoreData

public class PersistentService {
    
    static let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyFlashCard")
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error {
                print("Error setting up Core Data (\(error)).")
            }
        })
        return container
    }()
    
    public static func save() {
        let viewContext = self.persistentContainer.viewContext
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Error in saving: \(error)")
        }
    }
    
    public static func deleteAllObjects() {
        let viewContext = self.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSManagedObject.fetchRequest() as! NSFetchRequest<NSManagedObject>
        
        do {
            let objects = try viewContext.fetch(fetchRequest)
            for object in objects {
                viewContext.delete(object)
            }
            try viewContext.save()
        } catch let error as NSError {
            print("Error in saving: \(error)")
        }
    }
    
    
}
