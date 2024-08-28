//
//  ProspectEditView.swift
//  HotProspects
//
//  Created by Stanislav Popovici on 03/08/2024.
//

import SwiftData
import SwiftUI

struct ProspectEditView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Bindable var prospect: Prospect
    
    var body: some View {
        NavigationStack {
            Form {
                TextField(prospect.name, text: $prospect.name)
                    .textContentType(.name)
                    .font(.title)
                TextField(prospect.emailAddress, text: $prospect.emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
            }
            .navigationTitle("Edit")
            .toolbar {
                Button("Save") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Prospect.self, configurations: config)
        let example = Prospect(name: "Test name", emailAddress: "Test email", isContacted: false)
        
        return ProspectEditView(prospect: example)
                .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
