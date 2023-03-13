//
//  Configuration.swift
//  Husqvarna
//
//  Created by Anshu Kumar Ray on 12/03/23.
//

import Foundation

struct Configuration: Codable {
    let images: ImageUrls?
    
    enum CodingKeys: String, CodingKey {
        case images = "images"
    }
}

struct ImageUrls: Codable {
    let secureBaseUrl: String?
    let posterSizes: [String]?
    let backdropSizes: [String]?
    
    enum CodingKeys: String, CodingKey {
        case secureBaseUrl = "secure_base_url"
        case posterSizes = "poster_sizes"
        case backdropSizes = "backdrop_sizes"
    }
}
