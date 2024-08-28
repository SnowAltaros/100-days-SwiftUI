//
//  ContentView.swift
//  FavoritePictures
//
//  Created by Stanislav Popovici on 31/07/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var allPictures = Pictures()
    
    @State private var showSheet = false
    
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if allPictures.items == [] {
                    ContentUnavailableView("No pictures yet", systemImage: "photo", description: Text("Press top corner button to upload your picture."))
                } else {
                    List {
                        ForEach(allPictures.items.sorted()) { item in
                            NavigationLink {
                                DetailView(pictureItem: item)
                            } label: {
                                HStack {
                                    VStack {
                                        item.getImage(from: item.imageData)
                                            .resizable()
                                            .scaledToFit()
                                    }
                                    .frame(width: 100, height: 100)
                                    Text(item.name)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Favorite Pictures")
            .toolbar {
                Button {
                    showSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showSheet) {
                NewPictureView(pictures: allPictures)
            }
        }
    }
}

#Preview {
    ContentView()
}
