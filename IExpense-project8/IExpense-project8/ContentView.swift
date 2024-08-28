//
//  ContentView.swift
//  IExpense
//
//  Created by Stanislav Popovici on 06/06/2024.
//

import SwiftUI

// creating an object
struct ExpenseItem: Identifiable, Codable, Hashable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

// observable class with a list off all created objects
@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.setValue(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    
    // sorting the objects under variable 'type' Personal and Bussines
    var personalExpense: [ExpenseItem] {
        items.filter { $0.type == "Personal" }
    }
    
    var bussinesExpense: [ExpenseItem] {
        items.filter { $0.type == "Bussines" }
    }
}

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
                NavigationLink(destination: AddView(expenses: expenses)){
                    Image(systemName: "plus")
                }
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
