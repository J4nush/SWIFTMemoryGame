//
//  MemoGameModel.swift
//  MemoryGame
//
//  Created by Michał Ziółek on 07/11/2023.
//

import Foundation

struct MemoGameModel<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score = 0

    private var _indexOfTheOneAndOnlyFaceUpCard: Int?

        var indexOfTheOneAndOnlyFaceUpCard: Int? {
            get {
                cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
            }
            set {
                for index in cards.indices {
                    cards[index].isFaceUp = (index == newValue)
                }
                _indexOfTheOneAndOnlyFaceUpCard = newValue
            }
        }
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 4
                }else{
                    if cards[chosenIndex].hasBeenSeen { score -= 1 }
                    if cards[potentialMatchIndex].hasBeenSeen { score -= 1 }
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }

        mutating func shuffle() {
            for index in cards.indices {
                    cards[index].isFaceUp = false
                    cards[index].isMatched = false
                }
            score = 0
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
        var isFaceUp = false {
                    didSet {
                        if oldValue && !isFaceUp {
                            hasBeenSeen = true
                        }
        }
        }
        var hasBeenSeen: Bool = false
        var isMatched: Bool = false
        let content: CardContent
        let id: String
        
    }
    
}

extension Array {
        var oneAndOnly: Element? {
            if count == 1 {
                return first
            } else {
                return nil
            }
        }
    }
