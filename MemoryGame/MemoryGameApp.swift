//
//  MemoryGameApp.swift
//  MemoryGame
//
//  Created by student on 10/10/2023.
//

import SwiftUI

@main
struct MemoryGameApp: App {
    @StateObject var viewModel = MemoGameViewModel(themes: [
            ["🤙", "👅", "🍑", "🍌", "🐱", "🐵"],
            ["🌞", "🌙", "⭐", "🌈", "☁️", "🌦", "🌧"],
            ["🍎", "🍊", "🍋", "🍇"]
        ], themeColors: [.green, .red, .blue])
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
