//
//  MovieDetails.swift
//  Husqvarna
//
//  Created by Anshu Kumar Ray on 12/03/23.
//

import Foundation

struct MovieDetails: Codable, Hashable {
    let id = UUID()
    let title: String?
    let description: String?
    let posterPath: String?
    let movieDuration: Int?
    let backdropPath: String?
    let genres: [Genre]?
    let tagline: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case description = "overview"
        case posterPath = "poster_path"
        case movieDuration = "runtime"
        case backdropPath = "backdrop_path"
        case genres = "genres"
        case tagline
        case releaseDate = "release_date"
    }
}

struct Genre: Codable, Hashable {
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
