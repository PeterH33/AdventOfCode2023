//
//  day6.swift
//  AdventOfCodeTests
//
//  Created by Peter Hartnett on 12/6/23.
//

import SwiftUI

struct day6View: View {
    var body: some View {
        Text("hiya!")
    }
}

struct Day6{
    
    static func doink(){
        print("foobar")
    }
    
    static func part1(_ input: [Race]) -> Int{
        var numberOfWaysToBeat:[Double] = []
        for race in input{
            let lower: Double = ((race.time - sqrt(race.time * race.time - 4 * race.distance)) / 2)
            let upper: Double = ((race.time + sqrt(race.time * race.time - 4 * race.distance)) / 2) - 1
           
            print("lower: ", lower, " Upper: ", upper)
            print("Lower .floor: ", floor(lower), "Upper. cieling: ", ceil(upper))
            numberOfWaysToBeat.append(ceil(upper) - floor(lower))
            
        }
        print( numberOfWaysToBeat.reduce(1) {$0 * $1})
        return 0
    }
    
    struct Race{
        var time: Double = 0
        var distance: Double = 0
    }
    
    static func getData(_ fileName: String) -> [Race]{
        var returnData:[Race] = []
        
        if let fileURL = Bundle.main.url(forResource: fileName, withExtension: "txt"){
            if let fileContents = try? String(contentsOf: fileURL){
                let lines = fileContents.components(separatedBy: "\n")
                let times = getNumbers( lines[0] )
                let distances = getNumbers(lines[1])
                for (index, time) in times.enumerated(){
                    returnData.append(Race(time: Double(time), distance: Double(distances[index])))
                }
            }
        }
        
        return returnData
    }
    
    static func getNumbers(_ input: String) -> [Int]{
        let components = (input.components(separatedBy: " "))
        return components.compactMap{ Int($0)}
    }
}



#Preview {
    day6View()
}
