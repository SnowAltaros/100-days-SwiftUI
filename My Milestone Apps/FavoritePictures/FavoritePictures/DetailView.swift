//
//  DetailView.swift
//  FavoritePictures
//
//  Created by Stanislav Popovici on 31/07/2024.
//

import MapKit
import SwiftUI

struct DetailView: View {
    
    var pictureItem: PictureItem
    
    @State private var showMap = false
    
    @State private var startPosition = MapCameraPosition.region(
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
                           span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
    )
    
    
    
    var body: some View {
        NavigationStack {
            VStack {
                pictureItem.getImage(from: pictureItem.imageData)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .navigationTitle(pictureItem.name)
            }
            
            if pictureItem.latitude != 0.0 && pictureItem.longitude != 0.0 {
                VStack {
                    Button {
                        showMap.toggle()
                        if showMap {
                            startPosition = MapCameraPosition.region(
                                MKCoordinateRegion(center: pictureItem.locationCoordinate,
                                                   span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
                            )
                        }
                    } label: {
                        HStack {
                            Text("Press to show map")
                            Spacer()
                            Image(systemName: showMap ?  "chevron.up" : "chevron.down")
                        }
                        .padding()
                    }
                    .frame(height: 25)
                    .foregroundStyle(.secondary)
                    
                    if showMap {
                        Map(initialPosition: startPosition) {
                            Marker("", coordinate: pictureItem.locationCoordinate)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    DetailView(pictureItem: .example)
}
