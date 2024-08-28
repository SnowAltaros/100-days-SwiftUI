//
//  AddView.swift
//  Day59IExpense
//
//  Created by Stanislav Popovici on 07/07/2024.
//

import SwiftData
import SwiftUI

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Bindable var expense: ExpenseItem
    
    let types = ["Bussines", "Personal"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $expense.name)
                
                Picker("Type", selection: $expense.type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: expense.name, type: expense.type, amount: expense.amount)
                    modelContext.insert(item)
                    dismiss()
                }
            }
        }
        .onAppear() {
            expense.name = ""
            expense.amount = 0
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ExpenseItem.self, configurations: config)
        let expense = ExpenseItem(name: "Lunch", type: "Bussines", amount: 100)
        return AddView(expense: expense)
            .modelContainer(container)
    } catch {
    return Text("Failed to create container: \(error.localizedDescription)")
    }
}

