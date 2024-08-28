//
//  AddBookView.swift
//  Bookworm
//
//  Created by Stanislav Popovici on 01/07/2024.
//

import SwiftUI

extension String {
    func whiteSpaceAndEmpty() -> Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var date = Date.now
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of the book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    DatePicker("Date released", selection: $date, in: ...date, displayedComponents: .date)
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    
                    HStack {
                        Spacer()
                        RatingView(rating: $rating)
                        Spacer()
                    }
                }
                
                Section {
                    Button("Save") {
                        // check for empty spaces for title and author
                        if title.whiteSpaceAndEmpty() {
                            title = "Unknown"
                        } else if author.whiteSpaceAndEmpty() {
                            author = "Unknown"
                        }
                        //add book
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, date: date.formatted(date: .numeric, time: .omitted))
                        modelContext.insert(newBook)
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
