//
//  ResultsView.swift
//  DiceRoller
//
//  Created by Stanislav Popovici on 11/08/2024.
//

import SwiftUI

struct ResultsView: View {
    var results: [DiceResult]
    
    var body: some View {
        NavigationStack {
            if results.isEmpty == false {
                List(results) { result in
                    VStack(alignment: .leading) {
                        Text("Sides: \(result.numberOfSides)  Dice: \(result.numberOfDice)")
                        
                        Text(result.description)
                    }
                    .accessibilityElement()
                    .accessibilityLabel("Sides: \(result.numberOfSides)  Dice: \(result.numberOfDice), \(result.description)")
                }
                .navigationTitle("Results")
            }
        }
    }
}

#Preview {
    ResultsView(results: [DiceResult(numberOfSides: 6, numberOfDice: 2), DiceResult(numberOfSides: 8, numberOfDice: 4)])
}
