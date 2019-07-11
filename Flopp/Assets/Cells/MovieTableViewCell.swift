import UIKit
import Foundation

class MovieTableViewCell: UITableViewCell {

    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieName: UILabel!
    @IBOutlet var rentButton: UIButton!
    @IBOutlet var ratingsImage: UIImageView!
    @IBOutlet var criticsComment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
