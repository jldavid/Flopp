import Alamofire
import Foundation
import MagicalRecord
import SwiftyJSON

class APIClient {
    
    static let shared = APIClient()
    let endpoint = "http://www.stormpixel.com/flopp"
    
    func getMovies(completion: @escaping ([Movie], Error?) -> ()) {
        let url = "\(endpoint)/movies.php"
        var listings = [Movie]()
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            if (response.result.value as? NSArray != nil) {
                MagicalRecord.save({ localContext in
                    if let json = response.result.value {
                        let data = JSON(json).string
                        let storedMovies: StoredMovies? = StoredMovies.mr_createEntity(in: localContext)
                        storedMovies?.createdAt = NSDate()
                        storedMovies?.json = data!
                    }
                })
                if let jsonArray = response.result.value as? NSArray {
                    for jsonFragment in jsonArray {
                        if let json = jsonFragment as? [String: Any] {
                            let listing = Movie(json: json)
                            listings.append(listing)
                        }
                    }
                    print(listings)
                    completion(listings, nil)
                }
            } else if let error = response.result.error as Error? {
                print("error")
                completion([Movie](), error)
            }
        }
    }
    
    fileprivate init() {}
    
}
