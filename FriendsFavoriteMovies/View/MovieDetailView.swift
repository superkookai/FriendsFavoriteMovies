//
//  MovieDetailView.swift
//  FriendsFavoriteMovies
//
//  Created by Weerawut Chaiyasomboon on 19/05/2568.
//

import SwiftUI
import SwiftData

struct MovieDetailView: View {
    @Bindable var movie: Movie
    let isNew: Bool
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    init(movie: Movie, isNew: Bool = false) {
        self.movie = movie
        self.isNew = isNew
    }
    
    var sortedFriends: [Friend] {
        movie.favoritedBy.sorted(by: {$0.name < $1.name})
    }
    
    var body: some View {
        Form {
            TextField("Movie Title", text: $movie.title)
            
            DatePicker("Release Date", selection: $movie.releaseDate, displayedComponents: .date)
            
            if !sortedFriends.isEmpty {
                Section("Favorited By") {
                    ForEach(sortedFriends) { friend in
                        Text(friend.name)
                    }
                }
            }
        }
        .navigationTitle(isNew ? "New Movie" : "Movie")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        context.delete(movie)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MovieDetailView(movie: SampleData.shared.movie)
    }
}

#Preview("New Movie") {
    NavigationStack {
        MovieDetailView(movie: SampleData.shared.movie, isNew: true)
    }
}
