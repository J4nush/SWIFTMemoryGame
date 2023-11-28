//
//  MemoGameViewModel.swift
//  MemoryGame
//
//  Created by Michał Ziółek on 07/11/2023.
//

import Foundation
import SwiftUI

class MemoGameViewModel: ObservableObject {
    @Published private var model: MemoGameModel<String>
    var themes: [[String]] = [
        ["🤙", "👅", "🍑", "🍌", "🐱", "🐵"],
            ["🌞", "🌙", "⭐", "🌈", "☁️", "🌦", "🌧"],
            ["🍎", "🍊", "🍋", "🍇", "🥑", "🫐", "🍓", "🥝", "🍏", "🍍", "🧄"]
        ]
    var themeColors: [Color] = [.green, .cyan, .pink]
    
    @Published var currentThemeIndex = 0 {
            didSet {
                resetGame()
            }
        }
    var score: Int {
            model.score
        }
        var currentTheme: [String] {
            themes[currentThemeIndex]
        }
        
        var currentColor: Color {
            themeColors[currentThemeIndex]
        }
    
    
    var cards: Array<MemoGameModel<String>.Card> {
        model.cards
    }

    init() {
//        self.themes = themes
//        self.themeColors = themeColors
        self.model = MemoGameViewModel.createMemoryGame(with: themes[0])
          
    }
    
    static func createMemoryGame(with theme: [String]) -> MemoGameModel<String> {
            return MemoGameModel<String>(numberOfPairsOfCards: theme.count) { pairIndex in
                theme[pairIndex]
            }
        }

    
    func choose(card: MemoGameModel<String>.Card) {
            model.choose(card)
        }
        
        func shuffle() {
            model.shuffle()
        }
    func resetGame(){
        model = MemoGameViewModel.createMemoryGame(with: currentTheme)
    }
   
}
