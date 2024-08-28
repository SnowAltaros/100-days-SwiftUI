//
//  ImageGeometryReader.swift
//  LayoutAndGeometry
//
//  Created by Stanislav Popovici on 09/08/2024.
//

import SwiftUI

struct ImageGeometryReader: View {
    var body: some View {
        HStack {
            Text("Importatnt")
                .frame(width: 200)
                .background(.blue)
            
            GeometryReader { proxy in
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: proxy.size.width * 0.8)
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
        }
    }
}

#Preview {
    ImageGeometryReader()
}
