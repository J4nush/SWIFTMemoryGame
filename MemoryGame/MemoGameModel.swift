//
//  MemoGameModel.swift
//  MemoryGame
//
//  Created by Michał Ziółek on 07/11/2023.
//

import Foundation

struct MemoGameModel<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard: Int?

        mutating func choose(_ card: Card) {
            
            if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
               !cards[chosenIndex].isFaceUp,
               !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                    indexOfTheOneAndOnlyFaceUpCard = nil
                } else {
                    for index in cards.indices {
                        cards[index].isFaceUp = false
                    }
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp.toggle()
            }
        }

        mutating func shuffle() {
            for index in cards.indices {
                    cards[index].isFaceUp = false
                    cards[index].isMatched = false
                }
            cards.shuffle()
        }

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: String(pairIndex*2)))
            cards.append(Card(content: content, id: String(pairIndex*2+1)))
        }
        shuffle()
    }
    
    

    struct Card: Identifiable, Equatable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        let content: CardContent
        let id: String
    }
    
}

