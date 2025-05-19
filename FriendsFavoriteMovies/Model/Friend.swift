//
//  Friend.swift
//  FriendsFavoriteMovies
//
//  Created by Weerawut Chaiyasomboon on 19/05/2568.
//

import Foundation
import SwiftData

@Model
class Friend {
    var name: String
    var favoriteMovie: Movie? //Many-To-One >> Many Freinds can choose same favorite movie
    
    init(name: String) {
        self.name = name
    }
    
    static let sampleData = [
        Friend(name: "Elena"),
        Friend(name: "Graham"),
        Friend(name: "Mayuri"),
        Friend(name: "Rich"),
        Friend(name: "Rody"),
    ]
}

//When you set the value of a property at one end of a relationship (favoriteMovie), SwiftData automatically updates the corresponding property on the other end (favoritedBy) for you. You can choose which of the two properties to set.
