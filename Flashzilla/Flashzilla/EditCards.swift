//
//  EditCards.swift
//  Flashzilla
//
//  Created by Stanislav Popovici on 06/08/2024.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var cards = DataManager.load()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Promt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card", action: addCard)
                }
                
                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            
                            Text(cards[index].answer)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: removeCard)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
        }
    }
    
    func done() {
        dismiss()
    }
    
    func addCard() {
        let trimmedPromt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        
        guard trimmedPromt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let card = Card(prompt: trimmedPromt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        DataManager.save(cards)
        newPrompt = ""
        newAnswer = ""
    }
    
    func removeCard(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        DataManager.save(cards)
    }
}

#Preview {
    EditCards()
}
