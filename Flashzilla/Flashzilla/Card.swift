//
//  Card.swift
//  Flashzilla
//
//  Created by Stanislav Popovici on 05/08/2024.
//

import Foundation

struct Card: Codable, Identifiable, Hashable {
    var id = UUID()
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
