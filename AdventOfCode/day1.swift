//
//  day1.swift
//  AdventOfCode
//
//  Created by Peter Hartnett on 12/2/23.
//

import SwiftUI

struct day1: View {
    let wordDict = WordDictionary()
    
    var body: some View {
        VStack{
            Text( "First problem: \(getFirstLast(wordDict: wordDict)) ")
            Text("Second problem: \(getFLWithStrings(wordDict:wordDict))")
            
        }
    }
}


func getFLWithStrings(wordDict: WordDictionary) -> Int {
    var total = 0
    
    
    for line in wordDict.dictionary{
        
        var firstNumber = 0
        var currentString: String = ""
        for thisLetter in line{
            currentString.append(thisLetter)
            if let numberFound = checkInArray(word: currentString){
                if let wordNumber = numberFound.wordToInteger(){
                    firstNumber = wordNumber
                }
                if let numNumber = Int(numberFound){
                    firstNumber = numNumber
                }
                break
            }
        }
        total += firstNumber * 10
        
        var secondNumber = 0
        var currentStringB: String = ""
        for thisLetter in line.reversed(){
            currentStringB.append(thisLetter)
            if let numberFound = checkInArray(word: String(currentStringB.reversed())){
                if let wordNumber = numberFound.wordToInteger(){
                    secondNumber = wordNumber
                }
                if let numNumber = Int(numberFound){
                    secondNumber = numNumber
                }
                break
            }
        }
        total += secondNumber
        
        
    }
    
    //go through each line of the dictionary
    
    //add a letter from the begining, check if numset has something that is in the string.
    
    return total
}

public extension String {
    func wordToInteger() -> Int? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        return  numberFormatter.number(from: self) as? Int
    }
}


func checkInArray(word: String) -> String?{
    let numSet:[String] = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    for num in numSet{
        if word.contains(num){
            return num
        }
    }
    return nil
}


fileprivate func getFirstLast(wordDict: WordDictionary) -> Int{
    var strippedSet: [String] = []
    for line in wordDict.dictionary{
        strippedSet.append( line.removeCharacters(from: CharacterSet.decimalDigits.inverted) )
    }
    var total = 0
    for num in strippedSet{
        let firstNum = (Int(num.first?.description ?? "0") ?? 0) * 10
        let lastNum = Int(num.last?.description ?? "0") ?? 0
        total += firstNum + lastNum
    }
    
    return total
}

extension String {

    func removeCharacters(from forbiddenChars: CharacterSet) -> String {
        let passed = self.unicodeScalars.filter { !forbiddenChars.contains($0) }
        return String(String.UnicodeScalarView(passed))
    }

    func removeCharacters(from: String) -> String {
        return removeCharacters(from: CharacterSet(charactersIn: from))
    }
}

/// Container for the parsed Set based on WordList.txt
struct WordDictionary{
    var dictionary: [String]
    
    init() {
        self.dictionary = WordDictionary.getDictionary()
    }
    
    /// Fetches the stored WordList.txt and puts it into memory as the wordDictionary Set. Should it fail, there is a fatalError that will crash the game.
    private static func getDictionary() -> [String]{
        if let startDictionaryURL = Bundle.main.url(forResource: "aoc1", withExtension: "txt"){
            if let startDictionary = try? String(contentsOf: startDictionaryURL){
                return startDictionary.components(separatedBy: "\n")
            }
        }
        //if the function gets to here, there is a fatal error, kill program
        fatalError("Could not load start.txt from bundle")
    }
}

struct day1_Previews: PreviewProvider{
    static var previews: some View{
        day1()
    }
}
