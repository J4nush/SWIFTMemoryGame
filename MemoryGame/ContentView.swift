//
//  ContentView.swift
//  MemoryGame
//
//  Created by student on 10/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var displayedCards = ["🤙", "👅", "🍑", "🍌", "🐱" ,"🐵"]
    
    let themesIcons: [String] = ["smiley.fill", "shuffle", "pawprint.fill"]
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
    
    
    
    var body: some View {
        VStack {
            Text("Memo").font(.largeTitle).padding()
            cardDisplay
            HStack{
                ForEach(themes.indices, id: \.self) { index in
                    ThemeButtonView(icon: themesIcons[index], label: "Motyw \(index + 1)", color: currentColor) {
                        self.currentTheme = self.themes[index]
                        self.currentColor = self.themeColors[index]
                        shuffleCards()
                    }
                }
            
            }.padding()
        }
        
        
        
    }
    var cardDisplay: some View{
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], content: {
                ForEach(0..<currentTheme.count, id: \.self){
                    index in
                    CardView(content: currentTheme[index], color: currentColor).aspectRatio(2/3, contentMode: .fit)

                }
            }).padding()
        }
    }
}



#Preview {
    ContentView()
}
