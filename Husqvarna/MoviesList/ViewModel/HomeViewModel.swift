//
//  HomeViewModel.swift
//  Husqvarna
//
//  Created by Anshu Kumar Ray on 04/03/23.
//

import Combine
import Foundation
import Network

class HomeViewModel: ObservableObject {
    
    @Published var topRatedMovies: [Movies] = []
    
    @Published var isLoadingMovies: Bool = false
    
    @Published var shouldShowError = false
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let moviesService: MoviesServiceable
    
    @Published var selectedMovie: Movies? = nil
    
    init(moviesService: MoviesServiceable = MoviesService(networkRequest: NetworkRequestable())) {
        self.moviesService = moviesService
        fetchConfiguration()
    }
    
    func fetchConfiguration() {
        isLoadingMovies = true
        moviesService.getConfiguration()
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
                AppConfiguration.appConfig = response
                self?.fetchMoviesList()
            }
            .store(in: &subscriptions)
    }
    
    func fetchMoviesList() {
        isLoadingMovies = true
        moviesService.getMoviesList()
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
                self?.topRatedMovies = response.movies
            }
            .store(in: &subscriptions)
    }
    
    deinit {
        subscriptions.removeAll()
    }
    
    func getMovieDetailViewModel(index: Int) -> MovieDetailsViewModel {
        return MovieDetailsViewModel(movieId: selectedMovie?.movieId ?? 0)
    }
    
    func posterPathForIndex(index: Int) -> URL? {
        let config = AppConfiguration.appConfig
        let path = config?.images?.secureBaseUrl ?? ""
        if let posterSize = config?.images?.posterSizes, !posterSize.isEmpty {
            let original = posterSize.first(where: { value in
                value == "original"
            }) ?? posterSize.first ?? ""
            let imagePath = "\(path)/\(original)/\(topRatedMovies[index].posterPath ?? "")"
            let url = URL(string: imagePath)
            return url
        }
        return nil
    }
}
