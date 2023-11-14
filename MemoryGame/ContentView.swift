//
//  ContentView.swift
//  MemoryGame
//
//  Created by student on 10/10/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: MemoGameViewModel
    
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
            shuffleButtonDisplay
            themeButtonsDisplay
        }
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
            LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 85)), count: 4), spacing: 0, content: {
                ForEach(viewModel.cards) { card in
                    CardView(card: card, color: viewModel.currentColor)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(1)
                        .onTapGesture {
                            withAnimation {
                                viewModel.choose(card: card)
                            }
                        }
                }
            }).padding()
        }
    }
}




#Preview {
    ContentView(viewModel: MemoGameViewModel())
}
