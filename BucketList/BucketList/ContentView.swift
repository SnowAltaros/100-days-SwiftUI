//
//  ContentView.swift
//  BucketList
//
//  Created by Stanislav Popovici on 18/07/2024.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
                           span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    )
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isUnlocked {
            MapReader { proxy in
                ZStack(alignment: .topTrailing) {
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(viewModel.mapModel == "Hybrid" ? .hybrid : .standard)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    // option binding, for selectedPlace, it will open a sheet if the place is selected
                    .sheet(item: $viewModel.selectedPlace) { place in
                        //passing in a location view and a closure run when button save is pressed
                        EditView(location: place) {
                            viewModel.update(location: $0)
                        }
                    }
                    
                    Menu {
                        Picker("Map Style", selection: $viewModel.mapModel) {
                            ForEach(viewModel.mapModels, id: \.self) {
                                Text($0)
                            }
                        }
                    } label: {
                        Image(systemName: "square.2.layers.3d")
                            .imageScale(.large)
                            .padding(6)
                            .background(.white)
                            .clipShape(.circle)
                    }
                    .padding(.trailing)
                }
            }
        } else {
            Button("Unlock places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
            
                .alert("Error", isPresented: $viewModel.nonBiometricDevice) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(viewModel.errorMessage)
                }
                .alert("Error", isPresented: $viewModel.failBiometrics) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(viewModel.errorMessage)
                }
        }
    }
}

#Preview {
    ContentView()
}
