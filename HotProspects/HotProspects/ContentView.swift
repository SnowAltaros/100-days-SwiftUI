//
//  ContentView.swift
//  HotProspects
//
//  Created by Stanislav Popovici on 02/08/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SortProspectsView(filter: .none)
                .tabItem {
                    Label("Everyoane", systemImage: "person.3")
                }
            
            SortProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            
            SortProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
    }
}

#Preview {
    ContentView()
}
