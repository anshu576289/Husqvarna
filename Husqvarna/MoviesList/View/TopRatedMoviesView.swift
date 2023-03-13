//
//  TopRatedMoviesView.swift
//  Husqvarna
//
//  Created by Anshu Kumar Ray on 12/03/23.
//

import Combine
import SwiftUI

struct TopRatedMoviesView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var willMoveToNextScreen = false
    @State var gridLayout: [GridItem] = [GridItem()]
    
    var body: some View {
        VStack {
            if viewModel.isLoadingMovies {
                ProgressView {
                    Text("loading".localizedString)
                        .font(.title)
                }
            } else {
                if viewModel.shouldShowError {
                    Text("error_please_try_again".localizedString)
                        .font(.subheadline)
                } else {
                    HStack {
                        Text("top_rated_movies".localized("\(viewModel.topRatedMovies.prefix(MoviesList.prefix).count)"))
                            .font(.bold(.title2)())
                            .padding([.leading])
                            .padding(.top, Padding.paddingLarge)
                        Spacer()
                    }
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: gridLayout, alignment: .center, spacing: Spacing.medium) {
                            ForEach(viewModel.topRatedMovies.indices.prefix(MoviesList.prefix), id: \.self) { index in
                                RemoteImageView(
                                    url: viewModel.posterPathForIndex(index: index),
                                    placeholder: {
                                        Image(systemName: "photo").resizable().foregroundColor(.accentColor)
                                    },
                                    image: {
                                        $0.resizable().scaledToFill().cornerRadius(CornerRadius.cardViewRadius)
                                    }
                                )
                                .onTapGesture {
                                    viewModel.selectedMovie = viewModel.topRatedMovies[index]
                                    willMoveToNextScreen = true
                                }
                            }
                        }
                    }
                    .padding([.leading, .trailing, .bottom])
                }
                
            }
        }
        .background(Color(UIColor.darkGray))
        .edgesIgnoringSafeArea([.top])
        .fullScreenCover(isPresented: $willMoveToNextScreen, content: {
            let viewModel = viewModel.getMovieDetailViewModel(index: viewModel.selectedMovie?.movieId ?? 0)
            MovieDetailsView(viewModel: viewModel)
        })
    }
}
