//
//  ContentView.swift
//  Multiplication
//
//  Created by Stanislav Popovici on 15/05/2024.
//

import SwiftUI

struct StartEndButton: ViewModifier {
    var redOrGreenColor: Bool
    var textColor: Bool
    
    func body(content: Content) -> some View {
        content
            .frame(width: 150, height: 10)
            .padding(20)
            .background(redOrGreenColor ? .red : .green)
            .font(.title)
            .foregroundColor(textColor ? .black : .pink)
            .clipShape(.buttonBorder)
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .contentShape(Rectangle())
    }
}

extension View {
    func startAndEndButton(color: Bool, textColor: Bool) -> some View {
        modifier(StartEndButton(redOrGreenColor: color, textColor: textColor))
    }
}


struct ContentView: View {
    @State private var tables = Range(2...9)
    @State private var currentTable = 5
    
    @State private var questionsNumber = 5
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    @State private var score = 0
    
    @State private var allOfQuestions = [String]()
    @State private var selectedNrOfQuestions = [String]()
    
    @State private var allOfAnswers = [Int]()
    @State private var correctAnswer = 0
    
    @State private var isGameRuning = false
    
    @State private var count = 0
    
    @State private var isShowingMessage = false
    @State private var showingFinalScore = false
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @State private var totalCountQuestions = 0
    
    @State private var isCorectAnswer = false
    @State private var isOpacity = false
    @State private var isWrongAnswer = false
     
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.red, .green, .blue, .purple, .yellow, .orange], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                .saturation(0.9)

            VStack {
                if isGameRuning {
                    
                    Spacer()
                    
                    VStack {
                        Text("\(selectedNrOfQuestions[count])")
                            .font(.system(size: 60).bold())
                            .foregroundStyle(Color(.pink))
                    }
                    .padding()
                    
                    Spacer()
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(allOfAnswers, id: \.self) { number in
                            Button {
                                withAnimation {
                                    checkAnswer(number)
                                }
                            } label: {
                                Text("\(number)")
                                    .foregroundStyle(Color.red)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                            .frame(width: 80, height: 80)
                            .padding(10)
                            .background(.yellow)
                            .clipShape(.buttonBorder)
                            .shadow(radius: 10)
                            .font(.system(size: 50))
                            .rotation3DEffect(.degrees(isCorectAnswer && correctAnswer == number ? 360 : 0), axis: (x: 0.0, y: 1.0, z: 0.0))
                            .rotation3DEffect(.degrees(isWrongAnswer && correctAnswer != number ? 360 : 0), axis: (x: 0.0, y: 1.0, z: 0.0))
                            .opacity(isCorectAnswer && correctAnswer != number ? 0.25 : 1)
                            .opacity(isWrongAnswer && correctAnswer != number ? 0.25 : 1)
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    VStack {
                        Text("Score: \(score)")
                            .padding()
                        Text("Questions left: \(totalCountQuestions)")
                            .padding()
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button {
                        endGame()
                    } label: {
                        Text("End game")
                            .frame(maxWidth: .infinity)
                    }
                    .startAndEndButton(color: isGameRuning, textColor: isGameRuning)
                    
                    Spacer()
                    
                } else {
                    
                    Spacer()
                    
                    VStack {
                        Section("Please choose the multiplication table") {
                            Picker("Please choose the multiplication table", selection: $currentTable) {
                                ForEach(tables, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            .pickerStyle(.segmented)
                            
                        }
                        .font(.title2)
                    }
                    .padding()
                    
                    Spacer()
                    
                    VStack {
                        Section {
                            Text("How many questions would you like?")
                            Stepper("\(questionsNumber) questions", value: $questionsNumber, in: 5...30, step: 5)
                        }
                        .font(.title2)
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button {
                        generateQuestionsAndAnwers(currentTable)
                        newGame()
                    } label: {
                        Text("New Game")
                            .frame(maxWidth: .infinity)
                    }
                    .startAndEndButton(color: isGameRuning, textColor: isGameRuning)
                    
                    Spacer()
                }
            }
        }
            .alert(alertTitle, isPresented: $isShowingMessage) {
                Button("Next question", action: nextQuetion)
            } message: {
                if alertTitle == "Correct" {
                    Text(alertMessage)
                } else {
                    Text(alertMessage)
                }
            }
            .alert(alertTitle, isPresented: $showingFinalScore) {
                Button("Restart", action: endGame)
            } message: {
                Text("Your score is: \(score)")
            }
    }
    
    
    func generateQuestionsAndAnwers(_ number: Int) {
        for _ in 0..<questionsNumber {
            for i in 1...9 {
                let question = "\(number) * \(i)"
                allOfQuestions.append(question)
            }
        }
        
        for i in 1...9 {
            let answer = i * number
            allOfAnswers.append(answer)
        }
        
        allOfAnswers.shuffle()
        
        let startIndex = 0
        let endIndex = questionsNumber
        let sliceQuestion = allOfQuestions[startIndex..<endIndex]
        
        selectedNrOfQuestions = Array(sliceQuestion).shuffled()
        
        totalCountQuestions = questionsNumber
    }
    
    func checkAnswer(_ number: Int) {
        // the mess witch is working :)
        let question = selectedNrOfQuestions[count]
        let arrayQuestion = Array(question)
        let firstArrayIndex = arrayQuestion.first
        let lastArrayIndex = arrayQuestion.last
        let stringFirstIndex = String(firstArrayIndex!)
        let stringLastIndex = String(lastArrayIndex!)
        let integerFirstIndex = Int(stringFirstIndex) ?? 0
        let integerLastIndex = Int(stringLastIndex) ?? 0
        
        correctAnswer = integerFirstIndex * integerLastIndex
        
        
        if number == correctAnswer {
            isCorectAnswer = true
            score += 1
            alertTitle = "Correct"
            alertMessage = "Yes, \(selectedNrOfQuestions[count]) = \(correctAnswer)"
        } else {
            isWrongAnswer = true
            alertTitle = "Wrong"
            alertMessage = "No, \(selectedNrOfQuestions[count]) = \(correctAnswer)"
            score -= 1
            if score < 0 {
                score = 0
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isShowingMessage = true
        }
        
    }
    
    func nextQuetion() {
        if count < questionsNumber - 1 {
            count += 1
        } else {
            showingFinalScore = true
            alertTitle = "Total score"
        }
        totalCountQuestions -= 1
        allOfAnswers.shuffle()
        isCorectAnswer = false
        isWrongAnswer = false
    }
    
    
    func newGame() {
        isGameRuning = true
    }
    
    func endGame() {
        isGameRuning = false
        allOfAnswers = []
        allOfQuestions = []
        score = 0
        count = 0
    }
}

#Preview {
    ContentView()
}

