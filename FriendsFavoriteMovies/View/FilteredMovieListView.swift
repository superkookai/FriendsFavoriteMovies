//
//  FilteredMovieListView.swift
//  FriendsFavoriteMovies
//
//  Created by Weerawut Chaiyasomboon on 19/05/2568.
//

import SwiftUI
import SwiftData

struct FilteredMovieListView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationSplitView {
            MovieListView(titleFilter: searchText)
                .searchable(text: $searchText)
        } detail: {
            Text("Select a movie")
                .navigationTitle("Movie")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FilteredMovieListView()
        .modelContainer(SampleData.shared.modelContainer)
}
