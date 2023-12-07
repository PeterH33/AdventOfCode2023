//
//  day3.swift
//  AdventOfCode
//
//  Created by Peter Hartnett on 12/3/23.
//

import SwiftUI

struct Day3View: View {
    let data = (Day3.getLines())
    var parts:[Part] {
        Day3.getParts(dataSet: data)
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Text("Sum of parts numbers:\(Day3.sumPartsNumbers(parts: parts))")
        Text("Gear Ratio sum: \(Day3.findGearRatioSum(parts: parts))")
    }
}

struct Part: Equatable{
    static func == (lhs: Part, rhs: Part) -> Bool {
        lhs.value == rhs.value && lhs.symbolIndex! == rhs.symbolIndex!
    }
    
    var value: Int
    var symbol: Character?
    var symbolIndex: (Int, Int)?
}

struct Day3{
    
    static func findGearRatioSum(parts: [Part]) -> Int{
        var returnSum = 0
        for part in parts {
            if part.symbol == "*"{
                for otherPart in parts{
                    if part != otherPart && part.symbolIndex! == otherPart.symbolIndex!{
                        returnSum += part.value * otherPart.value
                    }
                }
            }
        }
        
        return returnSum / 2
    }
    
    static func sumPartsNumbers(parts: [Part]) -> Int{
        var returnInt: Int = 0
        for part in parts{
            if part.symbol != "."{
                returnInt += part.value
            }
        }
        return returnInt
    }
    
    static func getParts(dataSet: [[Character]]) -> [Part]{
        var returnValues: [Part] = []
        for (i,row) in dataSet.enumerated(){
            var currentNumber: String = ""
            var startI = 0
            var startJ = 0
            for (j,item) in row.enumerated(){
                if item.isNumber{
                    //if its a new number, capture the start index
                    if currentNumber == ""{
                        startI = i
                        startJ = j
                    }
                    //start adding to current number
                    currentNumber.append(item)
                    //If on last item in row
                    if (j + 1 == row.count){
                        if let (symbol,symbolIndex) = checkForSymbol(dataSet: dataSet, startI: startI, startJ: startJ, endI: i, endJ: j){
                            returnValues.append(Part(value: Int(currentNumber)!, symbol: symbol, symbolIndex: symbolIndex))
                        }
                        currentNumber = ""
                    }
                } else {
                    //if the item is not a number and we have a value for currentNumber, that means we finished a number
                    if currentNumber != "" {
                        if let (symbol,symbolIndex) = checkForSymbol(dataSet: dataSet, startI: startI, startJ: startJ, endI: i, endJ: j-1){
                            returnValues.append(Part(value: Int(currentNumber)!, symbol: symbol, symbolIndex: symbolIndex))
                        }
                        currentNumber = ""
                    }
                }
            }
        }
        return returnValues
    }
    
    static func checkForSymbol(dataSet: [[Character]], startI:Int, startJ:Int, endI: Int, endJ:Int) -> (Character,(Int,Int))?{
//        var returnCharacter: Character?
        
        for i in (startI - 1)...(endI + 1){
            if dataSet.indices.contains(i){
                for j in (startJ - 1)...(endJ + 1){
                    if dataSet[i].indices.contains(j){
                        if dataSet[i][j] != "." && !dataSet[i][j].isNumber{
                            return (dataSet[i][j],(i,j))
                        }
                    }
                }
            }
        }
        //fail state didnt find a symbol so return a .
        return nil
    }
    
    
    static func getLines() -> [[Character]]{
        var returnMatrix: [[Character]] = [[]]
        if let fileURL = Bundle.main.url(forResource: "aoc3", withExtension: "txt"){
            if let fileContents = try? String(contentsOf: fileURL){
                let lines = fileContents.components(separatedBy: "\n")
                for line in lines{
                    returnMatrix.append(Array(line)as![Character])
                }
                returnMatrix.removeFirst()
                returnMatrix.removeLast()
                return returnMatrix
            }
        }
          fatalError()
    }
    
}

#Preview {
    Day3View()
}
