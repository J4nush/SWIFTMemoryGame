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
    @State private var isMatchedAndAnimating = false
    
//    var body: some View {
//           GeometryReader { geometry in
//               ZStack {
//                   if !card.isFaceUp {
//                       RoundedRectangle(cornerRadius: 10.0).fill(.white).foregroundColor(.white)
//                       RoundedRectangle(cornerRadius: 10.0).stroke( color,lineWidth: 3).overlay(
//                        Text(card.content).font(Font.system(size: 200)).minimumScaleFactor(0.01).aspectRatio(contentMode: .fit)
//                       )
//                       
//                   } else if card.isMatched {
//                       RoundedRectangle(cornerRadius: 10.0).fill(color).opacity(0)
//                   } else {
//                       RoundedRectangle(cornerRadius: 10.0).fill(color)
//                   }
//               }
//           }
//    }
    var body: some View {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(card.isFaceUp ? .white : color)
                    .overlay(
                        circlePartOverlay
                    )
                    .overlay(
                        textOverlay

                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0).stroke(color, lineWidth: 3)
                    ).opacity(card.isMatched && !isMatchedAndAnimating ? 0 : 1).onChange(of: card.isMatched) {oldState, isMatched in
                        if isMatched {
                            withAnimation(Animation.rotating()) {
                                isMatchedAndAnimating = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isMatchedAndAnimating = false
                            }
                        }
                    }
            }
        }

        private var circlePartOverlay: some View {
            Group {
                if card.isFaceUp {
                    CirclePart(endAngle: CGFloat.pi*1.25)
                        .fill(color)
                        .aspectRatio(contentMode: .fit)
                        .opacity(0.5)
                        .rotationEffect(.degrees(-90))
                }
            }
        }

        private var textOverlay: some View {
            Group {
                if card.isFaceUp {
                    Text(card.content)
                        .font(Font.system(size: 80))
                        .aspectRatio(contentMode: .fit)
                        .rotationEffect(Angle.degrees(isMatchedAndAnimating ? 360 : 0))
                }
            }
        }
    
}

extension Animation {
    static func rotating() -> Animation {
        Animation.linear(duration: 2).repeatForever(autoreverses: false)
    }
}

#Preview {
    CardView(card: MemoGameViewModel().cards[0], color: .blue).onTapGesture {
        MemoGameViewModel().choose(card: MemoGameViewModel().cards[0])
    }
}
