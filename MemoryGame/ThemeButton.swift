//
//  ThemeButton.swift
//  MemoryGame
//
//  Created by Michał Ziółek on 17/10/2023.
//

import Foundation
import SwiftUI

struct ThemeButtonView: View {
    var icon: String
    var label: String
    var color: Color
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .font(.title2)
                Text(label).font(.title3)
            }
        }.foregroundColor(color)
    }
}

#Preview {
    ThemeButtonView(icon: "shuffle.circle", label: "elo",
                    color: .green, action:{print("text")} )
}
