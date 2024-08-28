//
//  SwiftUIView.swift
//  AccessibilitySandbox
//
//  Created by Stanislav Popovici on 24/07/2024.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        VStack {
            Image(.character)
                .accessibilityHidden(true)
        }
        
        VStack{
            Text("Your score is")
            
            Text("1000")
                .font(.title)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Your score is 1000")
    }
}

#Preview {
    SwiftUIView()
}
