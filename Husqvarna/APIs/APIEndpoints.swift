//
//  APIEndpoints.swift
//  Husqvarna
//
//  Created by Anshu Kumar Ray on 04/03/23.
//

import Foundation
import Network

typealias Headers = [String: String]

enum APIEndpoints {
    case getConfiguration
    case getPopularMovies
    case getMovieDetails(Int)
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getPopularMovies, .getMovieDetails, .getConfiguration:
            return .GET
        }
    }
    
    func createRequest(key: String, environment: AppEnvironment = .staging) -> NetworkRequest {
        let headers: Headers = [:]
        return NetworkRequest(key: key,
                              url: getURL(from: environment),
                              headers: headers,
                              reqBody: requestBody,
                              httpMethod: httpMethod)
    }
    
    var requestBody: Encodable? {
        switch self {
        case .getPopularMovies, .getMovieDetails, .getConfiguration:
            return nil
        }
    }
    
    func getURL(from environment: AppEnvironment) -> String {
        let baseUrl = environment.serviceBaseUrl
        switch self {
        case .getPopularMovies:
            return "\(baseUrl)/3/movie/top_rated"
        case .getMovieDetails(let id):
            return "\(baseUrl)/3/movie/\(id)"
        case .getConfiguration:
            return "\(baseUrl)/3/configuration"
        }
    }
}
