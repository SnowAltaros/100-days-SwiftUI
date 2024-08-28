//
//  SortProspectsView.swift
//  HotProspects
//
//  Created by Stanislav Popovici on 07/08/2024.
//

import SwiftUI

struct SortProspectsView: View {
    let filter: ProspectsView.FilterType
    @State private var sortOrder = SortDescriptor(\Prospect.name)
    var body: some View {
        NavigationStack {
            ProspectsView(filter: filter, sort: sortOrder)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by name")
                            .tag(SortDescriptor(\Prospect.name))
                        
                        Text("Sort by recents")
                            .tag(SortDescriptor(\Prospect.addedDate))
                    }
                }
            }
        }
    }
}

#Preview {
    SortProspectsView(filter: .none)
}
