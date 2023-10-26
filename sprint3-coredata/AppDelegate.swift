//
//  AppDelegate.swift
//  sprint3-coredata
//
//  Created by Owen Gometz on 10/26/23.
//

import Foundation
import CoreData
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        #if DEBUG
        // Clear UserDefaults
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
        
        // Clear Core Data Database
        let context = PersistenceController.shared.container.viewContext
        deleteAllData(in: "Chord", using: context)
      
        let context1 = PersistenceController.shared.container.viewContext
        deleteAllData(in: "Song", using: context1)
      
        let context2 = PersistenceController.shared.container.viewContext
        deleteAllData(in: "SongChordInstance", using: context2)
        
        #endif
        
        return true
    }
    
    func deleteAllData(in entityName: String, using context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Error deleting all data from \(entityName): \(error)")
        }
    }
}


