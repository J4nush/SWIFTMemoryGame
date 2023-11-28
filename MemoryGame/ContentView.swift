//
//  ContentView.swift
//  MemoryGame
//
//  Created by student on 10/10/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: MemoGameViewModel
    @State private var lastScoreChange: (score: Int, cardID: String?) = (0, nil)

    let themesIcons: [String] = ["face.smiling", "shuffle.circle", "pawprint.circle"]
    let themeColors: [Color] = [.green, .cyan, .pink]
    
    
    
    
    func changeTheme(to themeIndex: Int) {
            withAnimation(.easeInOut) {
                viewModel.currentThemeIndex = themeIndex
                shuffleCards()
            }
        }
    
    func shuffleCards() {
        viewModel.shuffle()
    }
    
    var body: some View{
        Text("Memo").font(.largeTitle)
        VStack{            cardDisplay
            HStack{
                scoreDisplay
                Spacer()
                shuffleButtonDisplay
            }.padding()
            
            themeButtonsDisplay
        }
    }
    
    var scoreDisplay: some View{
        Text("Wynik: \(viewModel.score)").font(.largeTitle)
    }
    
    var shuffleButtonDisplay: some View{
        Button("SHUFFLE"){
            withAnimation(.easeInOut) {
                viewModel.shuffle()
            }
        }.font(.title3).padding()
    }
    
    var themeButtonsDisplay: some View{
        HStack(spacing: 55){
            ForEach(viewModel.themes.indices, id: \.self) { index in
                ThemeButtonView(icon: themesIcons[index], label: "Motyw \(index + 1)", color: viewModel.currentColor) {
                    changeTheme(to: index)
                    
                }
            }
        }
    }
    
    var cardDisplay: some View{
        ScrollView{
            LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 85)), count: 3), spacing: 10, content: {
                ForEach(viewModel.cards) { card in
                    CardView(card: card, color: viewModel.currentColor)
                        .transformIntoCard(isFlipped: !card.isFaceUp)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(1)
                        .onTapGesture {
                            withAnimation {
//                                viewModel.choose(card: card)
                                handleCardTap(card)
                               
                            }
                        }
                    if lastScoreChange.cardID == card.id {
                        FlyingNumber(number: lastScoreChange.score)
                    }
                }
            }).padding()
        }
    }
    
    func scoreChange(for cardID: String) -> Int {
        return lastScoreChange.cardID == cardID ? lastScoreChange.score : 0
    }
    
    private func handleCardTap(_ card: MemoGameModel<String>.Card) {
            let previousScore = viewModel.score
            withAnimation {
                viewModel.choose(card: card)
            }
            let scoreChange = viewModel.score - previousScore
            if scoreChange != 0 {
                lastScoreChange = (scoreChange, card.id)
            }
        }
}




#Preview {
    ContentView(viewModel: MemoGameViewModel())
}
