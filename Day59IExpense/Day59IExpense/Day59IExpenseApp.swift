//
//  Day59IExpenseApp.swift
//  Day59IExpense
//
//  Created by Stanislav Popovici on 07/07/2024.
//

import SwiftData
import SwiftUI

@main
struct Day59IExpenseApp: App {
    
    let modelContainer: ModelContainer
        
        init() {
            do {
                modelContainer = try ModelContainer(for: ExpenseItem.self)
            } catch {
                fatalError("Could not initialize ModelContainer")
            }
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView(expense: ExpenseItem(name: "", type: "Bussines", amount: 0))
        }
        .modelContainer(modelContainer)
    }
}
