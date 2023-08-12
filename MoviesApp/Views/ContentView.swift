//
//  ContentView.swift
//  MoviesApp
//
//  Created by Kiwi on 10/08/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: MoviesViewModel
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(viewModel.movies) { movie in
                        NavigationLink {
                            let moviesViewModel = MoviesDetailsViewModel(netWorkService: NetworkService())
                            MovieDetailsView(movie: movie)
                                .environmentObject(moviesViewModel)
                        } label: {
                            MovieView(movie: movie)
                        }
                    }
                }
                .navigationTitle(Strings.moviesTitle)
            }
            .onAppear {
                viewModel.fetchPopulerMovies()
            }
            if viewModel.movies.isEmpty{
                Text(viewModel.errorText)
                    .font(.title3)
                    .padding([.leading, .trailing])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = MoviesViewModel(netWorkService: NetworkService())
        ContentView()
            .environmentObject(vm)
    }
}
