//
//  CardView.swift
//  MemoryGame
//
//  Created by student on 10/10/2023.
//

import Foundation
import SwiftUI

struct CardView: View {
    @State private var isFlipped: Bool = false
    var content: String
    var color: Color
    
    var body: some View{
        Group{
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
                    .overlay(
                        Text(content).font(.largeTitle)
                    )
                    .overlay(RoundedRectangle(
                        cornerRadius: 12
                    ).stroke(color, lineWidth: 2)
                    ).overlay( RoundedRectangle(cornerRadius: 12).fill(color).opacity(isFlipped ? 0 : 1)
                    )
        }.onTapGesture{
            isFlipped.toggle()
        }
    }
    
}



#Preview {
    CardView(content: "🐱", color: .blue)
}
