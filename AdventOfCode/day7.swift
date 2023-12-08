//
//  day7.swift
//  AdventOfCode
//
//  Created by Peter Hartnett on 12/7/23.
//

import SwiftUI

struct day7View: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Day7{
    
    static func getTotalWinnings(cards: [Card]) -> Int{
        var returnValue = 0
        let sortedCards = cards.sorted()
        for (index, card) in sortedCards.enumerated(){
            returnValue += card.bid * (index + 1)
            //            print(" Hand: ", card.hand, " Type: ", card.handType, " Hand Value: ", card.handValue)
        }
        return returnValue
    }
    
    
    static func convertHandTypeJackWild(hand: String, startingHandType: HandType) -> HandType{
        if hand.contains("J"){
            switch startingHandType{
            case .fiveOfAKind:
                return .fiveOfAKind
            case .fourOfAKind:
                return .fiveOfAKind
            case .fullHouse:
                return .fiveOfAKind
            case .threeOfAKind:
                return .fourOfAKind
            case .twoPair:
                var count = 0
                for thisLetter in hand{
                    if thisLetter == "J"{
                        count += 1
                    }
                }
                if count == 1{
                    return .fullHouse
                } else {
                    return .fourOfAKind
                }
            case .onePair:
                return .threeOfAKind
            case .highCard:
                return .onePair
            case .errorHand:
                return .errorHand
            }
        } else {
            return startingHandType
        }
    }
    
    
    static let cardOrder: [String : Int] = [
        "A" : 22,
        "K" : 21,
        "Q" : 20,
        "J" : 19,
        "T" : 18,
        "9" : 17,
        "8" : 16,
        "7" : 15,
        "6" : 14,
        "5" : 13,
        "4" : 12,
        "3" : 11,
        "2" : 10
    ]
    

    static let cardOrderJackWild: [String : Int] = [
        "A" : 22,
        "K" : 21,
        "Q" : 20,
        "J" : 10,
        "T" : 19,
        "9" : 18,
        "8" : 17,
        "7" : 16,
        "6" : 15,
        "5" : 14,
        "4" : 13,
        "3" : 12,
        "2" : 11
    ]

    
    struct Card: Comparable{
        static func < (lhs: Day7.Card, rhs: Day7.Card) -> Bool {
            (lhs.handType.rawValue, rhs.handValue) > (rhs.handType.rawValue, lhs.handValue)
        }
        
        var hand: String = ""
        var handType: HandType
        var bid: Int = 0
        var jackIsWild: Bool = false
        
        var handValue: Int  {
            var valueString = ""
            for thisLetter in hand{
                let stringLetter = String(thisLetter)
                valueString.append(String( jackIsWild ? cardOrderJackWild[stringLetter]! : cardOrder[stringLetter]!  ))
            }
            return Int(valueString)!
        }
    }
    
    
    enum HandType: Int{
        case fiveOfAKind = 0
        case fourOfAKind = 1
        case fullHouse = 2
        case threeOfAKind = 3
        case twoPair = 4
        case onePair = 5
        case highCard = 6
        case errorHand = 69
    }
    
    
    static func getHandType(_ inputString: String) -> HandType{
        var occurrenceDict: [String:Int] = [:]
        for thisLetter in inputString{
            if occurrenceDict[String(thisLetter)] == nil{
                occurrenceDict[String(thisLetter)] = 1
            } else {
                occurrenceDict[String(thisLetter)]! += 1
            }
        }
        switch occurrenceDict.count{
        case 1:
            return .fiveOfAKind
        case 2:
            if occurrenceDict.values.contains(4){
                return .fourOfAKind
            } else {
                return .fullHouse
            }
        case 3:
            if occurrenceDict.values.contains(3){
                return .threeOfAKind
            } else {
                return .twoPair
            }
        case 4:
            return .onePair
        case 5:
            return .highCard
        default:
            return .errorHand
        }
    }
    
    
    static func getCards(_ fileName:String, jackIsWild: Bool = false) -> [Card]{
        var returnCards:[Card] = []
        if let fileURL = Bundle.main.url(forResource: fileName, withExtension: "txt"){
            if let fileContents = try? String(contentsOf: fileURL){
                let lines = fileContents.components(separatedBy: "\n")
                for line in lines{
                    let handAndBid = line.components(separatedBy: " ")
                    if !handAndBid.isEmpty && handAndBid != [""]{
                        let handType = jackIsWild ? convertHandTypeJackWild(hand: handAndBid[0], startingHandType: getHandType(handAndBid[0])) : getHandType(handAndBid[0])
                        returnCards.append(
                            Card(
                                hand: handAndBid[0],
                                handType: handType,
                                bid: Int(handAndBid[1])!,
                                jackIsWild: jackIsWild
                            )
                        )
                    }
                }
            }
        }
        return returnCards
    }
    
}


#Preview {
    day7View()
}
