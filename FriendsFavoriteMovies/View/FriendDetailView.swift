//
//  FriendDetailView.swift
//  FriendsFavoriteMovies
//
//  Created by Weerawut Chaiyasomboon on 19/05/2568.
//

import SwiftUI
import SwiftData

struct FriendDetailView: View {
    @Bindable var friend: Friend
    let isNew: Bool
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    @Query(sort: \Movie.title) private var movies: [Movie]
    
    init(friend: Friend, isNew: Bool = false) {
        self.friend = friend
        self.isNew = isNew
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $friend.name)
                .autocorrectionDisabled()
            
            Picker("Favorite Movie", selection: $friend.favoriteMovie) {
                Text("None")
                    .tag(nil as Movie?)
                
                ForEach(movies) { movie in
                    Text(movie.title)
                        .tag(movie)
                }
            }
        }
        .navigationTitle(isNew ? "New Friend" : "Friend")
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
                        context.delete(friend)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FriendDetailView(friend: SampleData.shared.friend)
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("New Friend") {
    NavigationStack {
        FriendDetailView(friend: SampleData.shared.friend, isNew: true)
            .modelContainer(SampleData.shared.modelContainer)
    }
}
