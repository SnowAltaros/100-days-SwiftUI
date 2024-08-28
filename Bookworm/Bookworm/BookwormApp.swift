//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Stanislav Popovici on 30/06/2024.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
