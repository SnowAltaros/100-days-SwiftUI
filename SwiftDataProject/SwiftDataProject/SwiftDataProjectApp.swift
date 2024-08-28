//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Stanislav Popovici on 02/07/2024.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
