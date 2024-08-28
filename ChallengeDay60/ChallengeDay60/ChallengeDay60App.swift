//
//  ChallengeDay60App.swift
//  ChallengeDay60
//
//  Created by Stanislav Popovici on 08/07/2024.
//

import SwiftData
import SwiftUI

@main
struct ChallengeDay60App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
