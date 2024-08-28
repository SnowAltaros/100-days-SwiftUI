//
//  DiceView.swift
//  DiceRoller
//
//  Created by Stanislav Popovici on 10/08/2024.
//

import SwiftUI

struct DiceView: View {
    
    var faceNumber: Int
    
    var body: some View {
        if faceNumber <= 6 {
            ZStack {
                Image(systemName: "die.face.\(faceNumber).fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.green, lineWidth: 3))
            }
        } else {
            ZStack {
                Image(systemName: "die.face.1.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.green, lineWidth: 3))
                
                
                Text("X \(faceNumber)")
                    .foregroundStyle(.green)
                    .offset(y: 30)
                    
                
            }
        }
        
    }
}

#Preview {
    DiceView(faceNumber: 3)
}
