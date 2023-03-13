//
//  MockMoviesService.swift
//  HusqvarnaTests
//
//  Created by Anshu Kumar Ray on 12/03/23.
//

import Combine
@testable import Husqvarna

class MockService: MoviesServiceable {
    var didCallConfiguration = false

    func getConfiguration() -> AnyPublisher<Husqvarna.Configuration, Error> {
        let stub = Configuration(images: ImageUrls(secureBaseUrl: "https://image.tmdb.org/t/p/",
                                                   posterSizes: ["w92","w154","w185","w342","w500","w780","original"],
                                                   backdropSizes: ["w45","w185","h632","original"]))
        return Just(stub)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func getMoviesList() -> AnyPublisher<Husqvarna.MovieList, Error> {
        let movies1 = Movies(movieId: 1, title: "Shawshank Redemption", overview: "Title", posterPath: "test", backdropPath: "test")
        let movies2 = Movies(movieId: 2, title: "The GodFather", overview: "Title", posterPath: "test", backdropPath: "test")
        let movielist = MovieList(movies: [movies1, movies2])
        return Just(movielist)
            .setFailureType(to: Error.self)
             .eraseToAnyPublisher()
    }

    func getMovieDetails(movieId: Int) -> AnyPublisher<Husqvarna.MovieDetails, Error> {
        let movies = MovieDetails(title: "The GodFather", description: "OK Boss", posterPath: "Test", movieDuration: 123, backdropPath: "Test", genres: [], tagline: "Ok", releaseDate: "2012")
        return Just(movies)
            .setFailureType(to: Error.self)
             .eraseToAnyPublisher()
    }
}
