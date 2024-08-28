//
//  Expenses.swift
//  Day59IExpense
//
//  Created by Stanislav Popovici on 07/07/2024.
//

import Foundation
import SwiftData


@Model
class ExpenseItem {
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
    
    init(id: UUID = UUID(), name: String, type: String, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
}
