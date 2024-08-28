//
//  ContentView.swift
//  Day59IExpense
//
//  Created by Stanislav Popovici on 07/07/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    var expense: ExpenseItem
    
    @State private var showingAddExpense = false
    
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount)
    ]
    
    @State private var filter = "All"
    let filterOptions = ["All", "Bussines", "Personal"]
    
    
    var body: some View {
        NavigationStack {
            ExpensesView(showType: filter ,sortOrder: sortOrder)
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by name")
                            .tag([
                                SortDescriptor(\ExpenseItem.name),
                                SortDescriptor(\ExpenseItem.amount)
                            ])
                        
                        Text("Sort by amount")
                            .tag([
                                SortDescriptor(\ExpenseItem.amount),
                                SortDescriptor(\ExpenseItem.name)
                            ])
                    }
                }
                
                Menu("Filter", systemImage: "ellipsis.circle") {
                    Picker("Filter", selection: $filter) {
                        ForEach(filterOptions, id: \.self) {
                            Text($0)
                        }
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expense: expense)
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ExpenseItem.self, configurations: config)
        let expense = ExpenseItem(name: "Lunch", type: "Bussines", amount: 100)
        return ContentView(expense: expense)
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
