//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Stanislav Popovici on 14/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe black, right stripe white",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red",
        "Monaco": "Flag with two horizontal stripes. Top stripe red, bottom stripe white",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe is gold with crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner"
    ]
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0
    @State private var numberTapped = 0
    @State private var maxAttempts = false
    @State private var totalAttemps = 0
    
    @State private var selectedNumber = 0
    @State private var isCorrect = false
    
    @State private var isFadeOutOpacity = false
    
    
    struct FlagImage: View {
        var image: String
        
        var body: some View {
            Image(image)
                .clipShape(.capsule)
                .shadow(radius: 5)
        }
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 400)
            //LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3, id: \.self) { number in
                        Button {
                            withAnimation {
                                flagTapped(number)
                            }
                        } label: {
                            FlagImage(image: countries[number])
                            /*Image(countries[number])
                             .clipShape(.capsule)
                             .shadow(radius: 5)
                             */
                        }
                        .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                        .rotation3DEffect(.degrees(isCorrect && selectedNumber == number ? 360 : 0), axis: (x: 0.0, y: 1.0, z: 0.0))
                        .opacity(isFadeOutOpacity && selectedNumber != number ? 0.25 : 1)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            if scoreTitle == "Correct" {
                Text("Yes, this is \(countries[correctAnswer])")
            } else {
                Text("Ops, this is \(countries[numberTapped])")
            }
        }
        .alert("Total score", isPresented: $maxAttempts) {
            Button("Reset", action: reset)
        } message: {
            Text("Your total score is \(score)\nPlease press Reset to start again, Good luck!")
        }
    }
    func flagTapped (_ number: Int) {
        selectedNumber = number
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            isCorrect = true
            isFadeOutOpacity = true
        } else {
            scoreTitle = "Wrong"
            score -= 1
            isCorrect = true
            isFadeOutOpacity = true
            if score == -1 {
                score = 0
            }
            numberTapped = number
        }
        
        
        totalAttemps += 1
        if totalAttemps == 8 {
            maxAttempts = true
        }
        
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        isCorrect = false
        isFadeOutOpacity = false
    }
    
    func reset() {
        askQuestion()
        score = 0
        totalAttemps = 0
    }
}

#Preview {
    ContentView()
}
