import UIKit
import CoreData

class CoreDataHelper: NSObject {
    static let instance = CoreDataHelper()
    
    let coordinator: NSPersistentStoreCoordinator
    let context: NSManagedObjectContext
    
    override private init() {
        let modelURL = NSBundle.mainBundle().URLForResource("Model", withExtension: "momd")
        let model = NSManagedObjectModel(contentsOfURL: modelURL!)
        
        var error : NSError?
        coordinator = NSPersistentStoreCoordinator(managedObjectModel: model!)
        let docsURL = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).first as! NSURL
        
        let storeURL = docsURL.URLByAppendingPathComponent("store.sqlite")
        
        coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil, error: &error)
        
        if error != nil {
            println("Can't add store: \(error!.description)")
            abort()
        }
        
        context = NSManagedObjectContext()
        context.persistentStoreCoordinator = coordinator
        
    }
    
    static func save() { instance.context.save(nil) }
}
