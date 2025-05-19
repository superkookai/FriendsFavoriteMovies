//
//  MovieListView.swift
//  FriendsFavoriteMovies
//  Created by Weerawut Chaiyasomboon on 19/05/2568.
//

import SwiftUI
import SwiftData

struct MovieListView: View {
    @Query private var movies: [Movie]
    @Environment(\.modelContext) private var context
    
    @State private var newMovie: Movie?
    
    init(titleFilter: String = "") {
        //Cannot use Swift code in #Predicate ❌
        let predicate = #Predicate<Movie> { movie in
            titleFilter.isEmpty || movie.title.localizedStandardContains(titleFilter)
        }
        
        _movies = Query(filter: predicate, sort: \Movie.title)
    }
    
    var body: some View {
        Group {
            if !movies.isEmpty {
                List {
                    ForEach(movies) { movie in
                        NavigationLink(movie.title) {
                            MovieDetailView(movie: movie)
                        }
                    }
                    .onDelete(perform: deleteMovies(indexes:))
                }
            } else {
                ContentUnavailableView("Add Movies", systemImage: "film.stack")
            }
        }
        .navigationTitle("Movies")
        .toolbar {
            ToolbarItem {
                Button("Add Movie", systemImage: "plus", action: addMovie)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
        .sheet(item: $newMovie) { newMovie in
            NavigationStack {
                MovieDetailView(movie: newMovie, isNew: true)
            }
            .interactiveDismissDisabled()
        }
        
    }
    
    private func addMovie() {
        let newMovie = Movie(title: "", releaseDate: .now)
        context.insert(newMovie)
        self.newMovie = newMovie
    }
    
    private func deleteMovies(indexes: IndexSet) {
        for index in indexes {
            context.delete(movies[index])
        }
    }
}

#Preview {
    NavigationStack {
        MovieListView()
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Filtered") {
    NavigationStack {
        MovieListView(titleFilter: "last")
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Empty") {
    NavigationStack {
        MovieListView()
            .modelContainer(for: Movie.self, inMemory: true)
    }
}
