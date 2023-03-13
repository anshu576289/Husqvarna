//
//  ContentView.swift
//  Husqvarna
//
//  Created by Anshu Kumar Ray on 04/03/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.darkGray
    }
    
    var body: some View {
        ZStack {
            TabView {
                //Top Rated Movies
                TopRatedMoviesView(viewModel: viewModel)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                //Account View: For Demonstration
                AccountView()
                    .tabItem {
                        Label("Account", systemImage: "person.crop.circle")
                    }
                //Favorites View: For Demonstration
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "heart.fill")
                    }
                //Downloads View: For Demonstration
                DownloadsView()
                    .tabItem {
                        Label("Downloads", systemImage: "arrow.down")
                    }
                
                //Downloads View: For Demonstration
                Settings()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
            .accentColor(.white)
        }
        .colorScheme(.dark)
        .edgesIgnoringSafeArea([.top])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct AccountView: View {
    var body: some View {
        Text("Profile Information")
            .font(.headline)
            .foregroundColor(.accentColor)
    }
}

struct DownloadsView: View {
    var body: some View {
        Text("You have no downloads")
            .font(.headline)
            .foregroundColor(.accentColor)
    }
}

struct FavoritesView: View {
    var body: some View {
        Text("No Favorites/Watchlist")
            .font(.headline)
            .foregroundColor(.accentColor)
    }
}
