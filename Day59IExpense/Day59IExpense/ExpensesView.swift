//
//  ExpensesView.swift
//  Day59IExpense
//
//  Created by Stanislav Popovici on 07/07/2024.
//

import SwiftData
import SwiftUI

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
    
    var body: some View {
        List {
            ForEach(expenses) { item in
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
            .onDelete(perform: removeRow)
        }
    }
    
    init(showType: String, sortOrder: [SortDescriptor<ExpenseItem>]) {
        if showType == "Bussines" {
            _expenses = Query(filter: #Predicate<ExpenseItem> { expense in
                expense.type.contains("B")
            }, sort: sortOrder)
        } else if showType == "Personal" {
            _expenses = Query(filter: #Predicate<ExpenseItem> { expense in
                expense.type.contains("P")
            }, sort: sortOrder)
        } else {
            _expenses = Query(sort: sortOrder)
        }
    }
    
    func removeRow(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
    }
}

#Preview {
    ExpensesView(showType: "All" ,sortOrder: [SortDescriptor(\ExpenseItem.name)])
        .modelContainer(for: ExpenseItem.self)
}
