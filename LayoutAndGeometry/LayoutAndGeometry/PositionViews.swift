//
//  PositionViews.swift
//  LayoutAndGeometry
//
//  Created by Stanislav Popovici on 09/08/2024.
//

import SwiftUI

struct PositionViews: View {
    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            .background(.red)
//            .position(x: 60, y: 20)
        
        Text("Hello, again!")
            .background(.blue)
            .offset(x: 100, y: 100)
    }
}

#Preview {
    PositionViews()
}
