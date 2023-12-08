//
//  day1.swift
//  AdventOfCode
//
//  Created by Peter Hartnett on 12/2/23.
//

import SwiftUI


struct day1: View {
    let wordDict = Day1.WordDictionary()
    
    var body: some View {
        VStack{
            Text("Day 1")
            Text("Part 1: \(Day1.part1(wordDict: wordDict)) ")
            Text("Part 2: \(Day1.part2(wordDict:wordDict))")
            
        }
    }
}


struct Day1{
    
    static func part2(wordDict: WordDictionary) -> Int {
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
        return total
    }
    
    
    static func checkInArray(word: String) -> String?{
        let numSet:[String] = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        for num in numSet{
            if word.contains(num){
                return num
            }
        }
        return nil
    }
    
    
    static func part1(wordDict: WordDictionary) -> Int{
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
    
    
    struct WordDictionary{
        
        var dictionary: [String]
        
        init() {
            self.dictionary = WordDictionary.getDictionary()
        }
        
        private static func getDictionary() -> [String]{
            if let startDictionaryURL = Bundle.main.url(forResource: "aoc1", withExtension: "txt"){
                if let startDictionary = try? String(contentsOf: startDictionaryURL){
                    return startDictionary.components(separatedBy: "\n")
                }
            }
            fatalError("Could not load aoc.txt from bundle")
        }
    }
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


extension String {
    /// Uses a numberFormatter to convert a string such as one to the integer equivalent
    /// - Returns: Optional Int if it is possible to convert the string to an Int
    func wordToInteger() -> Int? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        return  numberFormatter.number(from: self) as? Int
    }
}


struct day1_Previews: PreviewProvider{
    static var previews: some View{
        day1()
    }
}
