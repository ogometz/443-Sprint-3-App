import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
      
        container = NSPersistentContainer(name: "sprint3_coredata")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    func importInitialDataIfNeeded() {
            let userDefaults = UserDefaults.standard
            let isInitialDataImported = userDefaults.bool(forKey: "isInitialDataImported")

//            if !isInitialDataImported {
                let chord_initializer = ChordDataInitializer()
                let song_initializer = SongDataInitializer()
                chord_initializer.initializeChordData(into: container.viewContext)
                song_initializer.initializeSongData(into: container.viewContext)
                userDefaults.set(true, forKey: "isInitialDataImported")
//            }
        }
}
