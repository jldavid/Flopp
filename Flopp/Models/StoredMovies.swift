import Foundation
import CoreData

@objc(StoredMovies)
class StoredMovies: NSManagedObject {
    
    @NSManaged var createdAt: NSDate
    @NSManaged var json: String
    
}
