//
//  AddActivitySheet.swift
//  ActivityTracker
//
//  Created by Stanislav Popovici on 19/06/2024.
//

import SwiftUI

struct AddActivitySheet: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var activityName = ""
    @State private var activityDescription = ""
    @State private var date = Date.now
    
    
    var activities: Activities
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Add your new activity") {
                    TextField("Activity", text: $activityName)
                }
                .listRowBackground(Color.palePink)
                
                Section("Describe your activity") {
                    TextField("Description", text: $activityDescription, axis: .vertical)
                }
                .listRowBackground(Color.palePink)
                
                Section("Today's date") {
                    DatePicker("Date picker", selection: $date, in: ...Date.now, displayedComponents: .date)
                }
                .listRowBackground(Color.palePink)
            }
            .navigationTitle("Add new activity")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        if activityName == "" || activityDescription == "" {
                            dismiss()
                        } else {
                            let activity = ActivityItem(name: activityName, description: activityDescription, count: 0, date: date.formatted(date: .numeric, time: .omitted), savedDates: [])
                            activities.items.append(activity)
                            dismiss()
                        }
                    } label: {
                        Text("Save")
                            .foregroundStyle(Color.white)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.pink)
            .foregroundStyle(.white)
            .tint(Color.pink)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    let activities = Activities()
    
    return AddActivitySheet(activities: activities)
}
