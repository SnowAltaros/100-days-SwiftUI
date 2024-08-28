//
//  Book.swift
//  Bookworm
//
//  Created by Stanislav Popovici on 01/07/2024.
//

import Foundation
import SwiftData

// observation to save this class in our data
@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var date: String
    let challengeDate = Date.now
    
    
    init(title: String, author: String, genre: String, review: String, rating: Int, date: String) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.date = date
    }
}
