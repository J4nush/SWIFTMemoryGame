//
//  FlyingNumber.swift
//  MemoryGame
//
//  Created by Michał Ziółek on 28/11/2023.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
        @State private var offset = CGFloat(0)
        @State private var opacity = 1.0

        var body: some View {
            Text("\(number >= 0 ? "+" : "")\(number)")
                .foregroundColor(number >= 0 ? .blue : .red)
                .shadow(color: .black, radius: 1)
                .offset(y: offset)
                .opacity(opacity)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 1.5)) {
                        offset = -100
                        opacity = 0
                    }
                }
                .onDisappear {
                    offset = 0
                }
        }
}

#Preview {
    FlyingNumber(number: -1)
}
