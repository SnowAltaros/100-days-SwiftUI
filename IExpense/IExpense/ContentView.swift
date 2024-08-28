//
//  ContentView.swift
//  IExpense
//
//  Created by Stanislav Popovici on 06/06/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    
    var body: some View {
        NavigationStack {
            List {
                Section("Bussines") {
                    ForEach(expenses.bussinesExpense) { item in
                        HStack{
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle(item.amount > 100 ? .red : item.amount <= 10 ? .green : .blue)
                                .font(item.amount > 100 ? .largeTitle : item.amount <= 10 ? .title2 : .title)
                        }
                    }
                    .onDelete(perform: removeBussinesItems)
                }
                
                Section("Personal") {
                    ForEach(expenses.personalExpense) { item in
                        HStack{
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle(item.amount > 100 ? .red : item.amount <= 10 ? .green : .blue)
                                .font(item.amount > 100 ? .largeTitle : item.amount <= 10 ? .title2 : .title)
                        }
                    }
                    .onDelete(perform: removePersonalItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeBussinesItems(at offsets: IndexSet) {
        for offset in offsets {
            if let index = expenses.items.firstIndex(where: {$0.id == expenses.bussinesExpense[offset].id}) {
                expenses.items.remove(at: index)
            }
        }
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        for offset in offsets {
            if let index = expenses.items.firstIndex(where: {$0.id == expenses.personalExpense[offset].id}) {
                expenses.items.remove(at: index)
            }
        }
    }
}

#Preview {
    ContentView()
}
