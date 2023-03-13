//
//  MoviesService.swift
//  Husqvarna
//
//  Created by Anshu Kumar Ray on 12/03/23.
//
import Combine
import Network

class MoviesService: MoviesServiceable {
    
    private var networkRequest: NetworkRequestProtocol
    private var environment: AppEnvironment
    
    init(networkRequest: NetworkRequestProtocol, environment: AppEnvironment = .staging) {
        self.networkRequest = networkRequest
        self.environment = environment
    }
    
    func getMoviesList() -> AnyPublisher<MovieList, Error> {
        let endpoint = APIEndpoints.getPopularMovies
        let request = endpoint.createRequest(key: apiKey, environment: self.environment)
        return self.networkRequest.request(request)
    }
    
    func getConfiguration() -> AnyPublisher<Configuration, Error> {
        let endpoint = APIEndpoints.getConfiguration
        let request = endpoint.createRequest(key: apiKey, environment: self.environment)
        return self.networkRequest.request(request)
    }
    
    func getMovieDetails(movieId: Int) -> AnyPublisher<MovieDetails, Error> {
        let endpoint = APIEndpoints.getMovieDetails(movieId)
        let request = endpoint.createRequest(key: apiKey, environment: self.environment)
        return self.networkRequest.request(request)
    }
    
    private var apiKey: String {
      get {
        // 1
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
          fatalError("Couldn't find file 'Info.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'Info.plist'.")
        }
        return value
      }
    }
}
