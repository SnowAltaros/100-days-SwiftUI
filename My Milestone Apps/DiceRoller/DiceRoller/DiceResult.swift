//
//  DiceResult.swift
//  DiceRoller
//
//  Created by Stanislav Popovici on 11/08/2024.
//

import Foundation

struct DiceResult: Identifiable, Codable {
    var id = UUID()
    var numberOfSides: Int
    var numberOfDice: Int
    
    var rolls = [Int]()
    
    var description: String {
        rolls.map(String.init).joined(separator: ", ")
    }
    
    init(numberOfSides: Int, numberOfDice: Int) {
        self.numberOfDice = numberOfDice
        self.numberOfSides = numberOfSides
        
        
        for _ in 0..<numberOfDice {
            let roll = Int.random(in: 1...numberOfSides)
            rolls.append(roll)
        }
    }
}
