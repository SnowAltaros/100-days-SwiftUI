import SwiftUI

struct ContentView: View {
    @State private var distance: Double = 0.0
    @State private var fromLengthType: String = "Km"
    @State private var toLengthType: String = "Miles"
    @FocusState private var amountIsFocused: Bool
    
    let lengthTypes = ["m", "Km", "Miles", "feet", "yard"]
    
    var converter: Double {
        var unitDistance = distance
        let fromUnit = fromLengthType
        let toUnit = toLengthType
        
        if toUnit == "Km" {
            unitDistance /= 1_000
        } else if toUnit == "Miles" {
            unitDistance /= 1_609
        } else if toUnit == "feet" {
            unitDistance *= 3.281 
        } else if toUnit == "yard" {
            unitDistance *= 1.094
        }
        
        if fromUnit == "Km" {
            unitDistance *= 1_000
        } else if fromUnit == "Miles" {
            unitDistance *= 1_609
        } else if fromUnit == "feet" {
            unitDistance /= 3.281
        } else if fromUnit == "yard" {
            unitDistance /= 1.094
        }
        
        
        return unitDistance 
    }
    
    // clear button to clear the text inside the textfield
    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var body: some View {
        NavigationStack {
                    Form {
                        Section {
                            TextField("Distance", value: $distance, format: .number)
                        }
                        .listRowBackground(Color.yellow)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                        .textFieldStyle(.roundedBorder)
                        Section("Convert from") {
                            Picker("From unit:", selection: $fromLengthType) {
                                ForEach(lengthTypes, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.segmented)
                            //.background(.indigo.gradient)
                        }
                        .listRowBackground(Color.yellow)
                        Section("To") {
                            Picker("To unit:", selection: $toLengthType) {
                                ForEach(lengthTypes, id:\.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.segmented)
                            //.background(.blue.gradient)
                        }
                        .listRowBackground(Color.yellow)
                        Section("Result:") {
                            Text(converter, format: .number)
                        }
                        //.listRowBackground(Color.yellow)
                    }
                    .background(.red.gradient)
                    .scrollContentBackground(.hidden)
                    .scrollDisabled(true)
                    .navigationTitle("Length converter")
                    .foregroundColor(.blue)
                    .toolbar {
                        if amountIsFocused {
                            Button("Done") {
                                amountIsFocused = false
                            }
                        }
                    }
                }
        .ignoresSafeArea()
    }
}
