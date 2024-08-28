import SwiftUI

struct ContentView: View {
    @State private var options = ["👊", "✋", "✌️"].shuffled()
    @State private var randomOption = Int.random(in: 0...2)
    @State private var randomCondition = Bool.random()
    @State private var score = 0
    @State private var textAnswer = ""
    @State private var showingAnswer = false
    @State private var scoreMessage = ""
    @State private var maxAttempts = 0
    @State private var showingTheEnd = false
    
    var condition: String {
        if randomCondition == true {
            return "Win"
        } else {
            return "Loose"
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Computer played: ")
                    .bold()
                Spacer()
                Text("\(options[randomOption])")
                    .font(.system(size: 50))
                    .padding(10)
                    .background(.black)
                    .clipShape(.buttonBorder)
                    .shadow(radius: 10)
                Spacer()
                Text("You should: ")
                    .bold()
                Spacer()
                Text("\(condition)")
                    .font(.title.smallCaps().bold())
                    .foregroundColor(condition == "Win" ? .green : .red)
                Spacer()
                HStack {
                    ForEach(0...2, id: \.self) { number in
                        Spacer()
                        Button {
                            tappedAnswer(number)
                        } label: {
                            Text("\(options[number])")
                                .padding(5)
                                .font(.system(size: 50))
                                .background(.black)
                                .clipShape(.buttonBorder)
                                .shadow(radius: 10)
                        }
                        Spacer()
                    }
                }
                Spacer()
                Text("Score: \(score)")
                    .bold()
            }
        }
        .alert(textAnswer, isPresented: $showingAnswer){
            Button("Continue", action: askAgain) 
        } message: {
            Text("\(scoreMessage)")
        }
        .alert("THE END",isPresented: $showingTheEnd) {
            Button("Reset", action: reset)
        } message: {
            Text("\n-------\nYour score is\n-------\n \(score)")
        }
    }
    func tappedAnswer(_ number: Int) {
        if options[number] == "👊" && options[randomOption] == "✌️" {
            textAnswer = "Win"
        } else if options[number] == "✋" && options[randomOption] == "👊" {
            textAnswer = "Win"
        } else if options[number] == "✌️" && options[randomOption] == "✋" {
            textAnswer = "Win"
        } else if options[number] == "👊" && options[randomOption] == "✋" {
            textAnswer = "Loose"
        } else if options[number] == "✌️" && options[randomOption] == "👊" {
            textAnswer = "Loose"
        } else if options[number] == "✋" && options[randomOption] == "✌️" {
            textAnswer = "Loose"
        } else {
            textAnswer = "Draw"
            scoreMessage = "No points"
        }
        
        if textAnswer == "Win" && randomCondition == true {
            score += 1
            scoreMessage = "You won 1 point"
        } else if textAnswer == "Win" && randomCondition == false  {
            score -= 1
            scoreMessage = "You lost 1 point"
        }else if textAnswer == "Loose" && randomCondition == false {
            score += 1
            scoreMessage = "You won 1 point"
        } else if textAnswer == "Loose" && randomCondition == true {
            score -= 1
            scoreMessage = "You lost 1 point"
        }
        
        if score < 0 {
            score = 0
        }
        
        showingAnswer = true
        
        maxAttempts += 1
        if maxAttempts == 10 {
            showingTheEnd = true
        }
    }
    
    func askAgain() {
        options.shuffle()
        randomOption = Int.random(in: 0...2)
        randomCondition = Bool.random()
    }
    
    func reset() {
        options.shuffle()
        randomOption = Int.random(in: 0...2)
        randomCondition = Bool.random()
        score = 0
        maxAttempts = 0
    }
}
