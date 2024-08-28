//
//  Expenses.swift
//  IExpense
//
//  Created by Stanislav Popovici on 19/06/2024.
//

import Foundation

// creating an object
struct ExpenseItem: Identifiable, Codable {
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
