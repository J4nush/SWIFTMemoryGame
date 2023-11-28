//
//  TransformIntoCard.swift
//  MemoryGame
//
//  Created by Michał Ziółek on 28/11/2023.
//

import SwiftUI

struct TransformIntoCard: ViewModifier {
    var isFlipped: Bool

    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                Angle.degrees(isFlipped ? 180 : 0),
                axis: (x: 0, y: 1, z: 0)
            )
    }
}

extension View {
    func transformIntoCard(isFlipped: Bool) -> some View {
        self.modifier(TransformIntoCard(isFlipped: isFlipped))
    }
}

//#Preview {
//    TransformIntoCard(isFlipped: false)
//}
