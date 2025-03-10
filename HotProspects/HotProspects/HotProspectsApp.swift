//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Stanislav Popovici on 02/08/2024.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
