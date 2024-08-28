//
//  ListActivitiesView.swift
//  ActivityTracker
//
//  Created by Stanislav Popovici on 19/06/2024.
//

import SwiftUI

struct ListActivitiesView: View {
    @State private var activities = Activities()
    
    var body: some View {
        List {
            ForEach(activities.items) { item in
                NavigationLink {
                    //link to destination
                } label: {
                    Text("\(item.activityName)")
                }
            }
            .onDelete(perform: removeActivity)
        }
    }
    func removeActivity(at offsets: IndexSet) {
        for offset in offsets {
            activities.items.remove(at: offset)
        }
    }
    
}

#Preview {
    ListActivitiesView()
}
