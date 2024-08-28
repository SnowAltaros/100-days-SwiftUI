//
//  NewPictureView.swift
//  FavoritePictures
//
//  Created by Stanislav Popovici on 31/07/2024.
//

import PhotosUI
import SwiftUI

struct NewPictureView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedImage: PhotosPickerItem?
    @State private var loadedPicture: Image?
    @State private var name = ""
    @State private var pictureData: Data?
    
    @State private var hasNameAndImage = false
    @State private var pictureIsLoaded = false
    
    var pictures: Pictures
    
    let locationFetcher = LocationFetcher()
    @State private var latitude: Double = 0.0
    @State private var longitude: Double = 0.0
    

    
    var body: some View {
        NavigationStack {
            VStack {
                PhotosPicker(selection: $selectedImage) {
                    if let loadedPicture {
                        loadedPicture
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .onChange(of: selectedImage, loadImage)
                .onChange(of: selectedImage, locationFetcher.start)
            }
            .frame(height: 500)
            .padding()
            
            VStack {
                TextField("Picture name", text: $name)
                    .onChange(of: name, activateSaveButton)
            }
            .padding()
            
            .toolbar {
                Button("Save") { 
                    saveToList()
                    dismiss()
                }
                .disabled(hasNameAndImage == false)
            }
        }
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedImage?.loadTransferable(type: Data.self) else { return }
            pictureData = imageData
            guard let inputImage = UIImage(data: imageData) else { return }
            
            loadedPicture = Image(uiImage: inputImage)
            pictureIsLoaded = true
        }
    }
    
    func saveToList() {
        if let newData = pictureData {
            if let location = locationFetcher.lastKnownLocation {
                let newPictureItem = PictureItem(name: name, imageData: newData, latitude: location.latitude, longitude: location.longitude)
                pictures.items.append(newPictureItem)
            } else {
                let newPictureItem = PictureItem(name: name, imageData: newData, latitude: latitude, longitude: longitude)
                pictures.items.append(newPictureItem)
            }
            
        }
    }
    
    func activateSaveButton() {
        if pictureIsLoaded && name != "" {
            hasNameAndImage = true
        }
    }
    
}

#Preview {
    NewPictureView(pictures: Pictures())
}
