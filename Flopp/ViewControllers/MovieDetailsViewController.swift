import UIKit
import Foundation

class MovieDetailsViewController: UIViewController {

    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieRating: UIImageView!
    @IBOutlet var criticsComment: UILabel!
    @IBOutlet var synopsisText: UITextView!
    
    var currentMovie:Movie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViews()
    }
    
    func loadViews() {
        setNeedsStatusBarAppearanceUpdate()
        movieTitle.text = currentMovie.name
        movieRating.image = UIImage(named: String(currentMovie.rating))
        criticsComment.text = "\"\(currentMovie.comment)\""
        synopsisText.text = currentMovie.synopsis
        movieImage.sd_setImage(with: URL(string: currentMovie.img), placeholderImage: UIImage(), options: .avoidAutoSetImage, completed: { (image, error, cache, url) in
            self.movieImage.image = image
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func closeDetails(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rentMovie(_ sender: Any) {
        
    }
    
}
