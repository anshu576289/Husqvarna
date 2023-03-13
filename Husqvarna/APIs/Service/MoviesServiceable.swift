//
//  MoviesServiceable.swift
//  Husqvarna
//
//  Created by Anshu Kumar Ray on 12/03/23.
//
import Combine
import Foundation
import Network

protocol MoviesServiceable: AnyObject {
    func getConfiguration() -> AnyPublisher<Configuration, Error>
    func getMoviesList() -> AnyPublisher<MovieList, Error>
    func getMovieDetails(movieId: Int) -> AnyPublisher<MovieDetails, Error>
}
