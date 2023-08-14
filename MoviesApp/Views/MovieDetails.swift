//
//  MovieDetailsView.swift
//  MoviesApp
//
//  Created by Kiwi on 10/08/23.
//

import SwiftUI

struct MovieDetailsView: View {
    @EnvironmentObject var viewModel: MoviesDetailsViewModel
    var movie: MovieUIModel
    var body: some View {
        GeometryReader{ geo in
            ScrollView {
                VStack() {
                    AsyncImage(url: URL(string: viewModel.movie?.thumbnail ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                            .scaledToFit()
                    }
                    .background(Color.gray)
                    .frame(height: geo.size.height * 0.75)
                    let row = GridItem(.fixed(50), spacing: 5, alignment: .center)
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [row]) {
                            ForEach(viewModel.movie?.gernes ?? [], id: \.self) { gerne in
                                Text(gerne)
                                    .foregroundStyle(.primary)
                                    .font(.system(.callout))
                                    .padding()
                                    .background(.indigo.opacity(0.2))
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    Divider()
                    VStack(alignment: .leading, spacing: 10) {
                        Text(viewModel.movie?.title ?? "")
                            .font(.title)
                        Text(viewModel.movie?.overview ?? "")
                    }
                }
                .padding(20)
                if viewModel.movie?.gernes?.isEmpty ?? true {
                    Text(MError.parsingError.rawValue)
                }
            }
            .onAppear {
                viewModel.getMovieDetails(id: movie.id ?? 0)
            }
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movie: MovieUIModel(id: 4, title: "Title",
                                             thumbnail: "https://image.tmdb.org/t/p/w500/4m1Au3YkjqsxF8iwQy0fPYSxE0h.jpg",
                                             overview: "",
                                             date: "08/01/1992",
                                             gernes: ["Comedy", "Thriller", "Adventure"]))
    }
}
