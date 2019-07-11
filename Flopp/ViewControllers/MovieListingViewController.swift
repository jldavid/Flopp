import UIKit
import Foundation
import SDWebImage
import MagicalRecord

class MovieListingViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!

    var refreshControl = UIRefreshControl()
    var movies:[Movie] = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movies.removeAll()
        setNeedsStatusBarAppearanceUpdate()
        setupTableView()
        setupRefreshControl()
        MovieAppManager.shared.getData { success, error in
            if success {
                self.movies = MovieDataManager.shared.getMovies()
                self.tableView.reloadData()
            } else {
                let storedMovie = StoredMovies.mr_findAll()
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension MovieListingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.addSubview(refreshControl)
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentMovie = movies[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsController = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        detailsController.currentMovie = currentMovie
        self.present(detailsController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        cell.movieName.text = movies[indexPath.row].name
        cell.ratingsImage.image = UIImage(named: String(movies[indexPath.row].rating))
        cell.rentButton.backgroundColor = UIColor.init(red: 207.0/255.0, green: 38.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        cell.movieImage.sd_setImage(with: URL(string: movies[indexPath.row].img), placeholderImage: UIImage(), options: .avoidAutoSetImage, completed: { (image, error, cache, url) in
            cell.movieImage.alpha = 0.0
            cell.movieImage.image = image
            cell.criticsComment.text = "\"\(self.movies[indexPath.row].comment)\""
            UIView.animate(withDuration: 0.3, animations: {
                cell.movieImage.alpha = 1.0
            })
        })
        return cell
    }
    
    @objc func addToCart(sender: UIButton) {

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 240.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (tableView.responds(to: #selector(setter: UITableViewCell.separatorInset))) {
            tableView.separatorInset = .zero
        }
        if (tableView.responds(to: #selector(setter: UIView.layoutMargins))) {
            cell.layoutMargins = .zero
        }
    }
    
    @objc func refresh(sender:AnyObject) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.refreshControl.endRefreshing()
        })
    }
    
}
