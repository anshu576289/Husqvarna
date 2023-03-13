//
//  MovieDetailsViewModel.swift
//  Husqvarna
//
//  Created by Anshu Kumar Ray on 11/03/23.
//

import Combine
import Network

class MovieDetailsViewModel: ObservableObject {

    private var subscriptions = Set<AnyCancellable>()
    
    private let moviesService: MoviesServiceable
    
    @Published var isLoadingMovies: Bool = false
    
    @Published var shouldShowError: Bool = false
    
    @Published var movieDetails: MovieDetails? = nil
    
    init(movieId: Int?, moviesService: MoviesServiceable = MoviesService(networkRequest: NetworkRequestable())) {
        self.moviesService = moviesService
        fetchMovieDetails(movieId: movieId)
    }
    
    func fetchMovieDetails(movieId: Int?) {
        isLoadingMovies = true
        moviesService.getMovieDetails(movieId: movieId ?? 0)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (completion) in
                switch completion {
                case .failure:
                    self?.shouldShowError = true
                case .finished:
                    break
                }
                self?.isLoadingMovies = false
            } receiveValue: { [weak self] (response) in
                self?.movieDetails = response
            }
            .store(in: &subscriptions)
    }
    
    deinit {
        subscriptions.removeAll()
    }
    
    var imageUrlString: URL? {
        let config = AppConfiguration.appConfig
        let path = config?.images?.secureBaseUrl ?? ""
        if let posterSize = config?.images?.posterSizes, !posterSize.isEmpty {
            let original = posterSize.first(where: { value in
                value == "original"
            }) ?? posterSize.first ?? ""
            
            let imagePath = "\(path)/\(original)/\(movieDetails?.backdropPath ?? "")"
            let url = URL(string: imagePath)
            return url
        }
        return nil
    }
    
    var movieDuration: String {
        let time = (movieDetails?.movieDuration ?? 0) * 60
        return time.secondsToTime()
    }
    
    var movieTagLine: String {
        movieDetails?.tagline ?? ""
    }
    
    var movieReleaseData: String {
        return movieDetails?.releaseDate ?? ""
    }
    
    var movieGenres: String {
        var finalString: String = ""
        if let genres = movieDetails?.genres {
            for (index,item) in genres.enumerated() {
                if index == genres.count - 1 {
                    finalString += "\(item.name ?? "")"
                } else {
                    finalString += "\(item.name ?? ""), "
                }
            }
        }
        return finalString
    }
}
