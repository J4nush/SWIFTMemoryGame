//
//  ContentView.swift
//  MemoryGame
//
//  Created by student on 10/10/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: MemoGameViewModel
    @State private var displayedCards = ["🤙", "👅", "🍑", "🍌", "🐱" ,"🐵"]
    
    let themesIcons: [String] = ["face.smiling", "shuffle.circle", "pawprint.circle"]
    let themeColors: [Color] = [.green, .red, .blue]
    
    @State private var currentTheme: [String] = ["🤙", "👅", "🍑", "🍌", "🐱", "🐵", "🤙", "👅", "🍑", "🍌", "🐱", "🐵"]
        let themes: [[String]] = [
            ["🤙", "👅", "🍑", "🍌", "🐱", "🐵", "🤙", "👅", "🍑", "🍌", "🐱", "🐵"],
            ["🌞", "🌙", "⭐", "🌈", "☁️", "🌦", "🌧", "⛈", "🌞", "🌙", "⭐", "🌈", "💧", "🌪️", "☄️", "❄️"],
            ["🍎", "🍊", "🍋", "🍇", "🍎", "🍊", "🍋", "🍇", "🍉", "🍉", "🥝", "🥝", "🍍", "🍍"]
        ]
    
    @State private var currentColor: Color = .green
    
    func shuffleCards() {
        currentTheme.shuffle()
    }
    
//    func addCards(){
//        let currentIndex = displayedCards.count
//        if currentIndex < cardContents.count{
//            let endIndex = min(currentIndex+2, cardContents.count)
//            displayedCards.append(contentsOf: cardContents[currentIndex..<endIndex])
//        }
//       
//    }
//    
//    func removeCards(){
//        if displayedCards.count > 2{
//            displayedCards.removeLast(2)
//        }
//    }
//    
//    func adjustCardNumber(by offset: Int)-> some View{
//        if offset > 0{
//            addCards()
//        }else if offset < 0{
//            removeCards()
//        }
//        return EmptyView()
//    }
    
    
    
//    var body: some View {
//        VStack {
//            Text("Memo").font(.largeTitle).padding()
//            cardDisplay
//            HStack(spacing: 55){
//                ForEach(themes.indices, id: \.self) { index in
//                    ThemeButtonView(icon: themesIcons[index], label: "Motyw \(index + 1)", color: currentColor) {
//                        self.currentTheme = self.themes[index]
//                        self.currentColor = self.themeColors[index]
//                        shuffleCards()
//                    }
//                }
//            
//            }.padding()
//        }
//        
//        
//        
//    }
    
    var body: some View{
        VStack{
            Text("Memo").font(.largeTitle).padding()
            cardDisplay
            Button("SHUFFLE"){
                viewModel.shuffle()
            }.font(.title3).padding()
            HStack(spacing: 55){
                ForEach(themes.indices, id: \.self) { index in
                    ThemeButtonView(icon: themesIcons[index], label: "Motyw \(index + 1)", color: viewModel.currentColor) {
                        withAnimation(.easeInOut) {
                        viewModel.currentThemeIndex = index
                    }
                        shuffleCards()
                    }
                    
                }
            }
        }.padding()
    }
    var cardDisplay: some View{
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))],spacing: 0, content: {
                ForEach(viewModel.cards) { card in
                    CardView(card: card, color: viewModel.currentColor)
                        .aspectRatio(3/4, contentMode: .fit)
                        .padding(1)
                        .onTapGesture {
                            withAnimation {
                                print(card)
                                viewModel.choose(card: card)
                            }
                        }
                }
            }).padding()
        }
    }
}



#Preview {
    ContentView(viewModel: MemoGameViewModel(themes: [
        ["🤙", "👅", "🍑", "🍌", "🐱", "🐵", "🤙", "👅", "🍑", "🍌", "🐱", "🐵"],
        ["🌞", "🌙", "⭐", "🌈", "☁️", "🌦", "🌧", "⛈", "🌞", "🌙", "⭐", "🌈", "💧", "🌪️", "☄️", "❄️"],
        ["🍎", "🍊", "🍋", "🍇", "🍎", "🍊", "🍋", "🍇", "🍉", "🍉", "🥝", "🥝", "🍍", "🍍"]
    ], themeColors: [.green, .red, .blue]))
}
