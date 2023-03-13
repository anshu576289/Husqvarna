//
//  MovieList.swift
//  Husqvarna
//
//  Created by Anshu Kumar Ray on 12/03/23.
//

import Foundation

struct MovieList: Codable {
    let movies: [Movies]
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movies: Codable, Hashable {
    let id = UUID()
    let movieId: Int?
    let title: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    
   enum CodingKeys: String, CodingKey {
        case title = "title"
        case overview = "overview"
        case posterPath = "poster_path"
        case movieId = "id"
        case backdropPath = "backdrop_path"
    }
}
