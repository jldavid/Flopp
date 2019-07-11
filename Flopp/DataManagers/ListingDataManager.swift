import Foundation

class MovieDataManager {

var movies = [Movie]()
static let shared = MovieDataManager()

func clearMovies() {
    movies.removeAll()
}

func addMovie(movie: Movie) {
    if movieExists(id: movie.id) == false {
        movies.append(movie)
    }
}

func addMovies(movies: [Movie]) {
    for movie in movies {
        if movieExists(id: movie.id) == false {
            self.movies.append(movie)
        }
    }
}

func getMovie(id: Int) -> Movie {
    let movie = movies.filter({ return $0.id == id })
    if let currentMovie = movie.first {
        return currentMovie
    } else {
        return Movie()
    }
}

func removeMovie(id: Int) {
    let filteredMovies = movies.filter{ $0.id != id }
    clearMovies()
    for movie in filteredMovies {
        movies.append(movie)
    }
}

func getMovies() -> [Movie] {
    return movies
}

func movieExists(id: Int) -> Bool {
    let movie = movies.filter({ return $0.id == id })
    if movie.isEmpty {
        return false
    } else {
        return true
    }
}

func printMovies() {
    for movie in movies {
        print(movie.name)
    }
}

fileprivate init() {}

}
