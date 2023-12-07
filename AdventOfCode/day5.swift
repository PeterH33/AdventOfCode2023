//
//  day5.swift
//  AdventOfCode
//
//  Created by Peter Hartnett on 12/5/23.
//

import SwiftUI

struct day5View: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Day5Data{
    var seeds:[Int] = []
    var conversionMaps:[Day5ConversionMap] = []
}

struct Day5ConversionMap{
    var inputType:String = ""
    var outputType:String = ""
    var conversions:[Day5Conversion] = []
}

struct Day5Conversion{
    var destinationRangeStart:Int
    var sourceRangeStart:Int
    var rangeLength:Int
}

struct Day5{
    
    
    
    static func getSeedRanges(_ inputData: Day5Data) -> [Range<Int>] {
        var returnArray:[Range<Int>] = []
        for index in stride(from: 0, to: inputData.seeds.count, by: 2){
            let lower = inputData.seeds[index]
            let upper = lower + inputData.seeds[index + 1]
            returnArray.append(lower..<upper)
        }
        return returnArray
    }
    
    static func part2(seedRanges: [Range<Int>], testData: Day5Data) -> Int{
        
        //for all seeds
        var locationRanges:[Range<Int>] = []
        for seedRange in seedRanges {
            var currentSeedRange = [seedRange]
            //process the seedRange into a locationRange by applying all conversionMaps
            for conversionMap in testData.conversionMaps {
//                print("\n conversionMap: ", conversionMap.inputType, "-", conversionMap.outputType)
//                print("range going in -",conversionMap.inputType, "- : " , currentSeedRange)
                currentSeedRange = applyConversionMapToRange(inputRange: currentSeedRange, conversionMap: conversionMap)
//                print("range out -", conversionMap.outputType, "- : ", currentSeedRange)
            }
            //add thisLocationRange to locationRanges
            
            locationRanges.append(contentsOf: currentSeedRange)
        }
        var lowestLocations:[Int] = []
        for locationRange in locationRanges {
            lowestLocations.append(locationRange.lowerBound)
        }
//        print("\n Lowest locations: ", lowestLocations)
        return lowestLocations.min()!
        //find and return the smallest value in all of the locationRanges(smallest lower bound)
        
    }
    
    
    
    static func applyConversionMapToRange(inputRange: [Range<Int>], conversionMap: Day5ConversionMap) -> [Range<Int>]{
//        print("****Running ", conversionMap.inputType, " to ", conversionMap.outputType, "conversion on", inputRange)
        var returnRange: [Range<Int>] = []
        
        //all different conversions
        for seedRange in inputRange{
//            print("     Checking seedRange: ", seedRange)
            var remainingSeedRanges: [Range<Int>] = [seedRange]
            
            for mapRangeValues in conversionMap.conversions{
                //maybe problem
                let mapRange = (mapRangeValues.sourceRangeStart..<(mapRangeValues.sourceRangeStart + mapRangeValues.rangeLength))
                
                //if we have not split or cut
                if remainingSeedRanges == [seedRange]{
                    //if it overlaps we cut and put remainder in remaining
//                    print("----Remaining Seeds is Empty: ", remainingSeedRanges.isEmpty)
                    if seedRange.overlaps(mapRange){
//                        print(seedRange, "Range overlaps with: ", mapRange, "Converting by + ", mapRangeValues.destinationRangeStart - mapRangeValues.sourceRangeStart)
                        let overlap = seedRange.clamped(to: mapRange)
//                        print("Clamped value: ", overlap)
                        let lower = mapRangeValues.destinationRangeStart - mapRangeValues.sourceRangeStart + overlap.lowerBound
                        let upper = mapRangeValues.destinationRangeStart - mapRangeValues.sourceRangeStart + overlap.upperBound
                        let convertedRange = (lower..<upper)
                        returnRange.append(convertedRange)
//                        print("Current return Range: ", returnRange)
                        let remainder = remainderOfClamped(seedRange, clampedTo: mapRange)
//                        print("Remainder from clamp: ", remainder)
                        remainingSeedRanges = remainder
                    }
                    //otherwise nothing
                } else {
//                    print("---- NOT Remaining Seeds is Empty: ", remainingSeedRanges.isEmpty)
                    // if we have split
                    for remainingSeedRange in remainingSeedRanges {
                        if remainingSeedRange.overlaps(mapRange){
//                            print(remainingSeedRange, "Range overlaps with: ", mapRange, "Converting by + ", mapRangeValues.destinationRangeStart - mapRangeValues.sourceRangeStart)
                            let overlap = remainingSeedRange.clamped(to: mapRange)
//                            print("Clamped value: ", overlap)
                            let lower = mapRangeValues.destinationRangeStart - mapRangeValues.sourceRangeStart + overlap.lowerBound
                            let upper = mapRangeValues.destinationRangeStart - mapRangeValues.sourceRangeStart + overlap.upperBound
                            let convertedRange = (lower..<upper)
                            returnRange.append(convertedRange)
//                            print("Current return Range: ", returnRange)
                            let remainder = remainderOfClamped(remainingSeedRange, clampedTo: mapRange)
//                            print("Remainder from clamp: ", remainder)
                            remainingSeedRanges = remainder
                        }
                        //otherwise nothing
                    }
                    
                }
            }
            
            remainingSeedRanges = remainingSeedRanges == [seedRange] ? [seedRange] : remainingSeedRanges
            returnRange.append(contentsOf: remainingSeedRanges)
            
            //for seedRange, if nothing happened add it to return
        }
        
        returnRange = returnRange.isEmpty ? inputRange : returnRange
//        print("***End ", conversionMap.inputType, " to ", conversionMap.outputType, "conversion on", inputRange)
//        print("returnRange: ", returnRange)
        return returnRange
    }
    
    
    static func remainderOfClamped(_ inputRange: Range<Int>, clampedTo clampRange: Range<Int>) -> [Range<Int>]{
        
        if inputRange.overlaps(clampRange){
            if inputRange == clampRange {
                return []
            }
            if clampRange.lowerBound < inputRange.lowerBound{
                if clampRange.upperBound < inputRange.upperBound{
                    return [(clampRange.upperBound..<inputRange.upperBound)]
                } else{
                    return []
                }
            }else{
                if clampRange.upperBound < inputRange.upperBound{
                    return [(inputRange.lowerBound..<clampRange.lowerBound), (clampRange.upperBound..<inputRange.upperBound)]
                } else{
                    // maybe -1
                    
                    return [(inputRange.lowerBound..<clampRange.lowerBound)]
                }
            }
        } else {
            return [inputRange]
        }
        
    }
    
    
    static func findLowestSeedPart1(_ inputData: Day5Data) -> Int?{
        var returnValue:Int = .max
        for seed in inputData.seeds {
            let currentSeedLocation = findSeedLocation(inputData, seed: seed)
            if currentSeedLocation < returnValue{
                returnValue = currentSeedLocation
            }
        }
        return returnValue
    }
    
    
    
    
    static func findSeedLocation(_ inputData: Day5Data, seed: Int) -> Int{
        //        var returnValue:Int = .max
        //        for seed in inputData.seeds {
        var currentSeedValue = seed
        for conversionMap in inputData.conversionMaps {
            for conversion in conversionMap.conversions {
                if Range(conversion.sourceRangeStart...(conversion.sourceRangeStart+conversion.rangeLength)).contains(currentSeedValue){
                    currentSeedValue = conversion.destinationRangeStart + currentSeedValue - conversion.sourceRangeStart
                    break
                }
            }
        }
        return currentSeedValue
        //            if currentSeedValue < returnValue{
        //                returnValue = currentSeedValue
        //            }
        //        }
        //        return returnValue
    }
    
    
    static func parseData(_ fileName:String) -> Day5Data{
        var returnData:Day5Data = Day5Data()
        if let fileURL = Bundle.main.url(forResource: fileName, withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                let blocks = fileContents.components(separatedBy: "\n\n")
                returnData.seeds = getNumbers(blocks[0])
                for (index, block) in blocks.enumerated() where index != 0{
                    var thisConversionMap = Day5ConversionMap()
                    let typeAndConversions = block.components(separatedBy: ":")
                    let types = typeAndConversions[0].components(separatedBy: "-")
                    thisConversionMap.inputType = types[0]
                    thisConversionMap.outputType = types[2].components(separatedBy: " ")[0]
                    let conversions = typeAndConversions[1].components(separatedBy: "\n")
                    for conversion in conversions {
                        //                        print(conversion)
                        let conversionValues = getNumbers(conversion)
                        if !conversionValues.isEmpty{
                            thisConversionMap.conversions.append(Day5Conversion(destinationRangeStart: conversionValues[0], sourceRangeStart: conversionValues[1], rangeLength: conversionValues[2]))
                        }
                    }
                    returnData.conversionMaps.append(thisConversionMap)
                    
                }
            }
        }
        
        return returnData
    }
    
    static func getNumbers(_ input: String) -> [Int]{
        let components = (input.components(separatedBy: " "))
        return components.compactMap{ Int($0) }
    }
}

#Preview {
    day5View()
}
