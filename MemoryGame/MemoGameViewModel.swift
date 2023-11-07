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
    let themes: [[String]]
    let themeColors: [Color]
    @Published var currentThemeIndex = 0 {
            didSet {
                resetGame()
            }
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

    init(themes: [[String]], themeColors: [Color]) {
        self.themes = themes
        self.themeColors = themeColors
        self.model = MemoGameViewModel.createMemoryGame(with: themes[0])
          
    }
    
    static func createMemoryGame(with theme: [String]) -> MemoGameModel<String> {
            return MemoGameModel<String>(numberOfPairsOfCards: theme.count / 2) { pairIndex in
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
