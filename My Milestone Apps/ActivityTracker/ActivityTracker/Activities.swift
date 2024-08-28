//
//  Avtivities.swift
//  ActivityTracker
//
//  Created by Stanislav Popovici on 19/06/2024.
//

import Foundation

struct ActivityItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let description: String
    var count: Int
    let date: String
    var savedDates: [String]
}

//class is monitoring for any data changes and encode and decode data in/from UserDefaults
@Observable
class Activities {
    var items = [ActivityItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.setValue(encoded, forKey: "Activities")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Activities") {
            if let decodedItems = try? JSONDecoder().decode([ActivityItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}
