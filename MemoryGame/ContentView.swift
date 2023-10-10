//
//  ContentView.swift
//  MemoryGame
//
//  Created by student on 10/10/2023.
//

import SwiftUI

struct ContentView: View {
    let cardContents = ["🤙", "👅", "🍑", "🍌", "🐱" ,"🐵"]
    @State private var displayedCards = ["🤙", "👅"]
    
    func addCards(){
        let currentIndex = displayedCards.count
        if currentIndex < cardContents.count{
            let endIndex = min(currentIndex+2, cardContents.count)
            displayedCards.append(contentsOf: cardContents[currentIndex..<endIndex])
        }
       
    }
    
    func removeCards(){
        if displayedCards.count > 2{
            displayedCards.removeLast(2)
        }
    }
    
    func adjustCardNumber(by offset: Int)-> some View{
        if offset > 0{
            addCards()
        }else if offset < 0{
            removeCards()
        }
        return EmptyView()
    }
    
    
    
    var body: some View {
        VStack {
           
            cardDisplay
            HStack{
                Button(action: {
                    adjustCardNumber(by: -2)
                }){
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20).padding()
                }.disabled(displayedCards.count == 2).border(.blue)
                Spacer()
                Button(action: {
                    adjustCardNumber(by: 2)
                }){
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20).padding()
                }.disabled(displayedCards.count == cardContents.count).border(.blue)
            }.padding()
        }
        
        
        
    }
    var cardDisplay: some View{
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], content: {
                ForEach(displayedCards, id: \.self){
                    content in
                    CardView(content: content)
                }
            }).padding()
        }
    }
}



#Preview {
    ContentView()
}
