//
//  MovieView.swift
//  MoviesApp
//
//  Created by Kiwi on 10/08/23.
//

import SwiftUI

struct MovieView: View {
    var movie: MovieUIModel

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: movie.thumbnail ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 400)
            
            VStack() {
                Text(movie.title ?? "")
                    .font(.headline)
                Text("\(Strings.releaseDate)\(movie.date ?? "")")
            }
            .padding([.top, .bottom], 10)
        }
        .frame(alignment: .leading)
    }
}


struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: MovieUIModel(id: 3,
                                      title: "Title",
                                      thumbnail: "",
                                      overview: "ansdjkjad nalskdn",
                                      date: "09/11/1922",
                                      gernes: ["Comedy", "Thriller"]))
    }
}
