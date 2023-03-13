//
//  MovieDescriptionView.swift
//  Husqvarna
//
//  Created by Anshu Kumar Ray on 12/03/23.
//
import Combine
import SwiftUI

struct MovieDescriptionView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: MovieDetailsViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    HStack(spacing: Spacing.small) {
                        Image(systemName: "chevron.left").imageScale(.medium)
                            .foregroundColor(.white)
                        Text("back".localizedString).font(.headline)
                        Spacer()
                    }
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding(.top, Padding.backButtonTopPadding)
                    .padding(.leading)
                    if viewModel.shouldShowError {
                        VStack(alignment: .center) {
                            Spacer()
                            Text("error_try_again".localizedString)
                                .font(.title2)
                            Spacer()
                        }
                        .padding()
                    } else {
                        Text(viewModel.movieDetails?.title ?? "")
                            .font(.bold(.largeTitle)())
                            .padding(.leading)
                            .padding(.top, Padding.mediumX)
                        
                        Text("movie_tagline".localized(viewModel.movieTagLine))
                            .font(.subheadline)
                            .padding([.leading, .trailing])
                            .padding(.top, Padding.extraSmall)
                        
                        RemoteImageView(
                            url: viewModel.imageUrlString,
                            placeholder: {
                                Image(systemName: "photo").foregroundColor(.accentColor)
                            },
                            image: {
                                $0.resizable().scaledToFit().cornerRadius(CornerRadius.cardViewRadius)
                            }
                          )
                        .padding()
        
                        HStack {
                            Text("movie_genre".localized(viewModel.movieGenres))
                                .font(.bold(.headline)())
                            Spacer()
                        }
                        .padding(.leading)
                        .padding(.top)
                        
                        HStack {
                            Text("movie_duration".localized(viewModel.movieDuration)).font(.subheadline)
                            Spacer()
                        }
                        .padding(.leading)
                        .padding(.top, Padding.extraSmall)
                        
                        Text("release_date".localized(viewModel.movieReleaseData))
                            .font(.subheadline)
                            .padding(.leading)
                            .padding(.top, Padding.extraSmall)
                        
                        Text(viewModel.movieDetails?.description ?? "")
                            .font(.caption)
                            .padding()
                    }
                    
                    Spacer()
                }
            }
        }
        .colorScheme(.dark)
        .background(Color(UIColor.darkGray))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}

