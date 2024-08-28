//
//  ActivityView.swift
//  ActivityTracker
//
//  Created by Stanislav Popovici on 19/06/2024.
//

import SwiftUI

struct ActivityView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var activityCount = 0
    
    @State private var date = Date.now
    
    @State var activityItem: ActivityItem
    
    var activities = Activities()
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section("Activity description") {
                        Text(activityItem.description)
                    }
                    .listRowBackground(Color.palePink)
                    
                    Section("Activity time tracker") {
                        Stepper("Activity count: \(activityCount)", value: $activityCount, in: 0...Int.max, step: 1)
                    }
                    .listRowBackground(Color.palePink)
                    
                    Section("Date") {
                        DatePicker("Date picker", selection: $date, in: ...Date.now, displayedComponents: .date)
                    }
                    .listRowBackground(Color.palePink)
                }
                
                List {
                    Section("All Dates") {
                        ForEach(activityItem.savedDates, id: \.self) { date in
                            Text(date)
                        }
                        .onDelete { indexSet in
                            activityItem.savedDates.remove(atOffsets: indexSet)
                        }
                    }
                    .listRowBackground(Color.palePink)
                }
            }
            .navigationTitle(activityItem.name)
            .toolbar() {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let index = activities.items.firstIndex(of: activityItem) {
                            
                            activities.items[index].count = activityCount
                            
                            activities.items[index].savedDates.append(date.formatted(date: .numeric, time: .omitted))
                            
                            dismiss()
                        }
                    }
                }
            }
            .onAppear() {
                activityCount = activityItem.count
            }
            .scrollContentBackground(.hidden)
            .background(.pink)
            .tint(.pink)
            .foregroundStyle(.white)
        }
        .preferredColorScheme(.dark)
    }
}


#Preview {
    let activityItem = ActivityItem(name: "Dancing", description: "Description", count: 0, date: "\(Date.now)", savedDates: [])
    
    return ActivityView(activityItem: activityItem)
}
