//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Stanislav Popovici on 09/08/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Live long and prospect")
            .frame(width: 300, height: 300, alignment: .topLeading)
        
        HStack(alignment: .lastTextBaseline) {
            Text("Live")
                .font(.caption)
            
            Text("long")
            
            Text("and")
                .font(.title)
            
            Text("prospect")
                .font(.largeTitle)
        }
    }
}

#Preview {
    ContentView()
}
