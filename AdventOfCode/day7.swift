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
    
    
    
//    enum cardOrder: Int  {
//        case A = 0
//        case K = 1
//        case Q = 2
//        case J = 3
//        case T = 4
//        case "9" = 5
//        
//        //        "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"}
//    }
    struct Card{
        var hand:String = ""
        var handType: HandType
        var bid:Int = 0
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
            _ = 1
            //can be 4ofakind or fullhouse
        case 3:
            _ = 1
            //can be three of a kind or 2pair
        case 4:
            return .onePair
        case 5:
            return .highCard
        default:
            return .errorHand
        }
        if occurrenceDict.count == 1{
            
        } else if occurrenceDict.count == 2{
            // can be 4ofaKind or Full house
        } else if occurrenceDict.count == 3{
            
        }
        
        
        return .errorHand
    }
    
    static func getCards(_ fileName:String) -> [Card]{
        var returnCards:[Card] = []
        if let fileURL = Bundle.main.url(forResource: fileName, withExtension: "txt"){
            if let fileContents = try? String(contentsOf: fileURL){
                let lines = fileContents.components(separatedBy: "\n")
                for line in lines{
                    let handAndBid = line.components(separatedBy: " ")
                    if !handAndBid.isEmpty && handAndBid != [""]{
                        //determine hand type
                        print("Hand and Bid: ", handAndBid)
                        returnCards.append(Card(hand: handAndBid[0], handType: getHandType(handAndBid[0]), bid: Int(handAndBid[1])!))
                        print(returnCards)
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
