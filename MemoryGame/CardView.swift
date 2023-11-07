//
//  CardView.swift
//  MemoryGame
//
//  Created by student on 10/10/2023.
//

import Foundation
import SwiftUI

struct CardView: View {
    
    let card: MemoGameModel<String>.Card
    var color: Color
    var body: some View {
           GeometryReader { geometry in
               ZStack {
                   if card.isFaceUp {
                       RoundedRectangle(cornerRadius: 10.0).fill(.white).foregroundColor(.white)
                       RoundedRectangle(cornerRadius: 10.0).stroke( color,lineWidth: 3).overlay(
                        Text(card.content).font(Font.system(size: 200)).minimumScaleFactor(0.01).aspectRatio(contentMode: .fit)
                       )
                       
                   } else if card.isMatched {
                       RoundedRectangle(cornerRadius: 10.0).fill(color).opacity(0)
                   } else {
                       RoundedRectangle(cornerRadius: 10.0).fill(color)
                   }
               }
           }
    }
    
}



#Preview {
    CardView(card: MemoGameViewModel(themes: [
        ["🤙", "👅", "🍑", "🍌", "🐱", "🐵", "🤙", "👅", "🍑", "🍌", "🐱", "🐵"],
        ["🌞", "🌙", "⭐", "🌈", "☁️", "🌦", "🌧", "⛈", "🌞", "🌙", "⭐", "🌈", "💧", "🌪️", "☄️", "❄️"],
        ["🍎", "🍊", "🍋", "🍇", "🍎", "🍊", "🍋", "🍇", "🍉", "🍉", "🥝", "🥝", "🍍", "🍍"]
    ], themeColors: [.green, .red, .blue]).cards[0], color: .blue)
}
