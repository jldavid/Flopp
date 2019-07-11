import Foundation

class MovieAppManager {
    
    static let shared = MovieAppManager()

    func getData(completion: @escaping (Bool, Error?) -> ()) {
        APIClient.shared.getMovies { movies, error in
            if movies.count > 0 {
                MovieDataManager.shared.addMovies(movies: movies)
            }
            completion(true, nil)
        }
    }

    fileprivate init() {}

}
