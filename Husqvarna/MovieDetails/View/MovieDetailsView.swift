//
//  MovieDetailsView.swift
//  Husqvarna
//
//  Created by Anshu Kumar Ray on 11/03/23.
//

import SwiftUI
import Combine

struct MovieDetailsView: View {
    @ObservedObject var viewModel: MovieDetailsViewModel
    
    var body: some View {
        if viewModel.isLoadingMovies {
            ProgressView {
                Text("loading".localizedString)
                    .font(.title)
            }
        } else {
            MovieDescriptionView(viewModel: viewModel)
        }
    }
}
