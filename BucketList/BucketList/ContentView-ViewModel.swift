//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Stanislav Popovici on 22/07/2024.
//

import CoreLocation
import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
    @Observable
    class ViewModel {
        //you can read this var but can't change it
        private(set) var locations: [Location]
        var selectedPlace: Location?
        
        var isUnlocked = false
        
        let mapModels = ["Standart", "Hybrid"]
        var mapModel = "Standart"
        
        var nonBiometricDevice = false
        var failBiometrics = false
        var errorMessage = ""
        
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        // init to decode straight our saved location
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "NewLocation", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = " Please authenticate yourself tp unlock your places. "
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.failBiometrics = true
                        self.errorMessage = "Sorry, the biometrics failed, try again!"
                    }
                }
            } else {
                self.nonBiometricDevice = true
                self.errorMessage = "Sorry, but your device don't support biometric verification"
            }
        }
    }
}
