//
//  ContentView.swift
//  Instafilter
//
//  Created by Stanislav Popovici on 15/07/2024.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntenssity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    
    @State private var selectedItem: PhotosPickerItem?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingFilters = false
    
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    @State private var hasAnImage = false
    
    @State private var haveIntensityFilterKey = false
    @State private var haveRadiusFilterKey = false
    @State private var haveScaleFilterKey = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)
                .onChange(of: selectedItem, activateButonAndSlider)
                
                Spacer()
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntenssity)
                        .onChange(of: filterIntenssity, applyProcessing)
                        .disabled(hasAnImage == false)
                        .disabled(haveIntensityFilterKey == false)
                }
                
                HStack {
                    Text("Radius")
                    Slider(value: $filterRadius)
                        .onChange(of: filterRadius, applyProcessing)
                        .disabled(hasAnImage == false)
                        .disabled(haveRadiusFilterKey == false)
                }
                
                HStack {
                    Text("Scale")
                    Slider(value: $filterScale)
                        .onChange(of: filterScale, applyProcessing)
                        .disabled(hasAnImage == false)
                        .disabled(haveScaleFilterKey == false)
                }
                
                
                HStack {
                    Button("Change filter", action: changeFilter)
                        .disabled(hasAnImage == false)
                    
                    Spacer()
                    
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter", image: processedImage))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Box Blur") { setFilter(CIFilter.boxBlur()) }
                Button("Circular Wrap") { setFilter(CIFilter.circularWrap()) }
                Button("") { setFilter(CIFilter.bloom()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    func activateButonAndSlider() {
        hasAnImage.toggle()
    }
    
    func changeFilter() {
        showingFilters = true
        haveScaleFilterKey = false
        haveRadiusFilterKey = false
        haveIntensityFilterKey = false
    }
    
    // method to load image, it's a async so we use task
    func loadImage() {
        Task {
            guard let imageData =  try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    
    
    // method to process our image with filter
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            haveIntensityFilterKey = true
            currentFilter.setValue(filterIntenssity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            haveRadiusFilterKey = true
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            haveScaleFilterKey = true
            currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
    
    // method to set selected filter
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        
        filterCount += 1
        
        if filterCount >= 20 {
            requestReview()
        }
    }
}

#Preview {
    ContentView()
}
