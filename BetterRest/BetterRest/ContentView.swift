//
//  ContentView.swift
//  BetterRest
//
//  Created by Stanislav Popovici on 09/05/2024.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeAmount = 1
    @State private var maxCoffeAmount = theMaxCoffeAmount
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var componetns = DateComponents()
        componetns.hour = 7
        componetns.minute = 0
        return Calendar.current.date(from: componetns) ?? .now
    }
    
    static var theMaxCoffeAmount: [Int] {
        var list = [Int]()
        for i in 1...20 {
            list.append(i)
        }
        let finalList = list
        return finalList
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("                       Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                /*Section("                               Daily coffe intake") {
                   Stepper("^[\(coffeAmount) cup](inflect: true)", value: $coffeAmount, in: 1...20)
                }*/
                
                Section("                               Daily coffe intake") {
                    Picker("Cup(s)", selection: $coffeAmount) {
                        ForEach(maxCoffeAmount, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section("                   When do you want to wake up") {
                    HStack{
                        Spacer()
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .datePickerStyle(WheelDatePickerStyle())
                        /// onChange is used to trigger a function when one of the parameter is changed
                            .onChange(of: wakeUp) { calculateBedtime() }
                        Spacer()
                    }
                }
                    
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("Ok") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
    
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime"
        }
        
        showingAlert = true
    }
    
    
    func autoCalc(use function: () -> Void) -> String {
    
        return ""
    }
    
}

#Preview {
    ContentView()
}
