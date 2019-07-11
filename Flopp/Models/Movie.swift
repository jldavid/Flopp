import Foundation

class Movie: NSObject {
    
    var id: Int
    var img: String
    var name: String
    var year: Int
    var comment: String
    var rating: Int
    var synopsis: String
    
    init(id: Int, img: String, name: String, make: String, model: String, year: Int, comment: String, rating: Int, synopsis: String) {
        self.id = id
        self.img = img
        self.name = name
        self.year = year
        self.rating = rating
        self.comment = comment
        self.synopsis = synopsis
    }
    
    init(json: [String: Any]) {
        self.id = json["id"] as? Int ?? 0
        self.img = json["img"] as? String ?? ""
        self.name = json["name"] as? String ?? ""
        self.comment = json["comment"] as? String ?? ""
        self.rating = json["rating"] as? Int ?? 0
        self.year = json["year"] as? Int ?? 0
        self.synopsis = json["synopsis"] as? String ?? ""
        super.init()
    }
    
    convenience override init() {
        self.init(json: ["":""])
    }
    
}
