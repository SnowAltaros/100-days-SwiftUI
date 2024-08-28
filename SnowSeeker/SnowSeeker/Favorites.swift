//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Stanislav Popovici on 19/08/2024.
//

import SwiftUI

@Observable
class Favorites {
    // key to remember witch place we are reading and writing from
    private let key = "Favorites"
    // actual resorts user favorited
    private var resorts: Set<String>
    
    
    // init to load our saved data
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: key) {
            if let decodedItem = try? JSONDecoder().decode(Set<String>.self, from: savedItems) {
                resorts = decodedItem
                return
            }
        }
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}
