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
    
    var body: some View{
        Group{
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
                    .frame(minWidth: 120, minHeight: 50)
                    .overlay(
                        Text(content).font(.largeTitle)
                    )
                    .overlay(RoundedRectangle(
                        cornerRadius: 12
                    ).stroke(.blue, lineWidth: 2)
                    ).overlay( RoundedRectangle(cornerRadius: 12).fill(.blue).opacity(isFlipped ? 0 : 1)
                    )
        }.onTapGesture{
            isFlipped.toggle()
        }
    }
    
}



#Preview {
    CardView(content: "🐱")
}
