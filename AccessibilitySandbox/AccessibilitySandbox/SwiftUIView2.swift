//
//  SwiftUIView2.swift
//  AccessibilitySandbox
//
//  Created by Stanislav Popovici on 24/07/2024.
//

import SwiftUI

struct SwiftUIView2: View {
    var body: some View {
        Button("John Fitzgerald Kennedy") {
            print("button tapped")
        }
        .accessibilityInputLabels(["John Fitzgerald Kennedy", "Kennedy", "JFK"])
    }
}

#Preview {
    SwiftUIView2()
}
