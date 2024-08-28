//
//  ContentView.swift
//  ActivityTracker
//
//  Created by Stanislav Popovici on 19/06/2024.
//

import SwiftUI


struct ContentView: View {
    @State private var sheetIsShown = false
    
    @State private var activities = Activities()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities.items) { item in
                    NavigationLink {
                        ActivityView(activityItem: item, activities: activities)
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Started day: \(item.date)")
                                    .font(.caption2)
                                Text(item.name)
                                    .font(.title)
                                Text(item.description)
                            }
                            .padding(.horizontal)
                            
                            Spacer()
                            
                            VStack {
                                Text("\(item.count)")
                                    .padding()
                                    .frame(maxHeight: .infinity)
                                    .frame(width: 70)
                            }
                            .background(Color.gray)
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay() {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray)
                        }
                    }
                }
                .onDelete(perform: removeRow)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.pink)
            }
            .navigationTitle("Your activities")
            .listRowSpacing(10)
            .toolbar {
                Button("Add new activity") {
                    sheetIsShown.toggle()
                }
                .foregroundStyle(Color.white)
            }
            .sheet(isPresented: $sheetIsShown) {
                AddActivitySheet(activities: activities)
            }
            .listStyle(.plain)
            .background(Color.pink)
        }
        .preferredColorScheme(.dark)
    }
    
    func removeRow(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
