//
//  EditView.swift
//  BucketList
//
//  Created by Stanislav Popovici on 19/07/2024.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    
    var onSave: (Location) -> Void
    
    @State private var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                
                Section("Nearby...") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                        
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            
                            + Text(": ") +
                            
                            Text(page.description)
                                .italic()
                        }
                        
                    case .failed:
                        Text("Please try again later")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = viewModel.location
                    newLocation.id = UUID()
                    newLocation.name = viewModel.name
                    newLocation.description = viewModel.description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
    
    // init to load the location and asign new states to our @State name and description
    // @escaping is used when the closure will not be used straight awai when the view is open
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
        
        //_name = State(initialValue: location.name)
        //_description = State(initialValue: location.description)
        _viewModel = State(initialValue: ViewModel(location: location))
    }
    
}

#Preview {
    EditView(location: .example, onSave: { _ in })
}
