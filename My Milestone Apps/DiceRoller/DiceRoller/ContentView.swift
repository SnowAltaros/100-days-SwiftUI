//
//  ContentView.swift
//  DiceRoller
//
//  Created by Stanislav Popovici on 10/08/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @AppStorage("numberOfSides") var numberOfSides = 4
    @AppStorage("diceOnTable") var diceOnTable = 1
    
    @State private var currentResult = DiceResult(numberOfSides: 0, numberOfDice: 0)
    
    let columns: [GridItem] = [
        .init(.adaptive(minimum: 100))
    ]
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var stoppedDice = 0
    
    let savePath = URL.documentsDirectory.appending(path: "SavedRolls.json")
    @State private var savedResults = [DiceResult]()
    
    @State private var isShowingResults = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Select the number of sides for the dice")
                Picker("Number of dice faces", selection: $numberOfSides) {
                    ForEach(4...24, id: \.self) { number in
                        if number.isMultiple(of: 2) {
                            Text("\(number)")
                        }
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 10)
                .disabled(stoppedDice < currentResult.rolls.count)
            }
            
            VStack {
                Text("Select the number of dice on table")
                Picker("Number of dice faces", selection: $diceOnTable) {
                    ForEach(1...9, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 10)
                .disabled(stoppedDice < currentResult.rolls.count)
            }
            
            VStack {
                LazyVGrid(columns: columns) {
                    ForEach(0..<currentResult.rolls.count, id: \.self) { rollNumber in
                        DiceView(faceNumber: currentResult.rolls[rollNumber])
                    }
                }
            }
            .padding()
            .accessibilityElement()
            .accessibilityLabel("Latest roll: \(currentResult.description)")
        
            
            Button("Roll", action: rollDice)
                .padding()
                .background(.green)
                .clipShape(.buttonBorder)
                .disabled(stoppedDice < currentResult.rolls.count)
            
            .navigationTitle("Dice Roller")
            .onReceive(timer) { date in
                updateDice()
            }
            .onAppear(perform: load)
            .sheet(isPresented: $isShowingResults) {
                ResultsView(results: savedResults)
            }
            .toolbar {
                Button("Results") {
                    isShowingResults = true
                }
            }
            .sensoryFeedback(.impact, trigger: currentResult.rolls)
        }
    }
    
    func rollDice() {
        currentResult = DiceResult(numberOfSides: numberOfSides, numberOfDice: diceOnTable)
        
        if accessibilityVoiceOverEnabled {
            stoppedDice = diceOnTable
            savedResults.insert(currentResult, at: 0)
            save()
        } else {
            stoppedDice = -20
        }
    }
    
    func updateDice() {
        guard stoppedDice < currentResult.rolls.count else { return }
        
        for i in stoppedDice..<diceOnTable {
            if i < 0 { continue }
            currentResult.rolls[i] = Int.random(in: 1...numberOfSides)
        }
        
        stoppedDice += 1
        
        if stoppedDice == diceOnTable {
            savedResults.insert(currentResult, at: 0)
            save()
        }
    }
    
    func load() {
        if let data = try? Data(contentsOf: savePath) {
            if let results = try? JSONDecoder().decode([DiceResult].self, from: data) {
                savedResults = results
            }
        }
    }
    
    func save() {
        if let data =  try? JSONEncoder().encode(savedResults) {
            try? data.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
}

#Preview {
    ContentView()
}
