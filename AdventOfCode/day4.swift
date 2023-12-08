//
//  day4.swift
//  AdventOfCode
//
//  Created by Peter Hartnett on 12/4/23.
//

import SwiftUI

struct day4View: View {
    var body: some View{
        Text("Hiya")
    }
}



struct Day4{
    
    struct Card{
        var cardNumber:Int
        var winningNumbers: [Int]
        var playerNumbers: [Int]
        var numberOfCopies: Int = 1
    }
    
    
    static func countCards() -> Int{
        var cards = getCards(fileName: "aoc4")
        var returnCount = 0
        
        for (cardIndex, card) in cards.enumerated(){
            print("Looking at card: \(card.cardNumber) copies: \(cards[cardIndex].numberOfCopies)")
            var matchingNumberCount = 0
            for playerNumber in card.playerNumbers {
                if card.winningNumbers.contains(playerNumber){
                    matchingNumberCount += 1
                }
            }
            
            for nextCardsIndex in card.cardNumber ..< card.cardNumber + matchingNumberCount{
                if cards.indices.contains(nextCardsIndex){
                    cards[nextCardsIndex].numberOfCopies += cards[cardIndex].numberOfCopies
                }
            }
            
            returnCount += cards[cardIndex].numberOfCopies
        }
        return returnCount
    }
    
    
    static func countPoints(cards: [Card]) -> Int{
        var returnTotal = 0
        for card in cards {
            var thisCardTotal = 1
            for playerNumber in card.playerNumbers {
                if card.winningNumbers.contains(playerNumber){
                    thisCardTotal = thisCardTotal * 2
                }
            }
            returnTotal += thisCardTotal / 2
        }
        return returnTotal
    }
    
    
    static func getCards(fileName: String) -> [Card]{
        var returnCards: [Card] = []
        
        if let fileURL = Bundle.main.url(forResource: fileName, withExtension: "txt"){
            if let fileContents = try? String(contentsOf: fileURL){
                let lines = fileContents.components(separatedBy: "\n")
                for line in lines{
                    if line != ""{
                        let cardAndNums = line.components(separatedBy: ":")
                        let cardNumber = getNumbers(cardAndNums[0])
                        let winAndPlayerNums = cardAndNums[1].components(separatedBy: "|")
                        let winningNumbers = getNumbers(winAndPlayerNums[0])
                        let playerNumbers = getNumbers(winAndPlayerNums[1])
                        returnCards.append(Card(cardNumber: cardNumber.first!, winningNumbers: winningNumbers, playerNumbers: playerNumbers))
                    }
                }
            }
        }
        
        return returnCards
    }
    
    
    static func getNumbers(_ input: String) -> [Int]{
        let components = (input.components(separatedBy: " "))
        return components.compactMap{ Int($0) }
    }
    
}

#Preview {
    day4View()
}
