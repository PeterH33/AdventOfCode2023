//
//  AdventOfCodeTests.swift
//  AdventOfCodeTests
//
//  Created by Peter Hartnett on 12/3/23.
//

import XCTest
@testable import AdventOfCode

final class AdventOfCodeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func DISABLEDtestDay4() throws {
//        print(Day2.parseGames(lines: Day2.getLines()))
        let _ = Day4.getCards(fileName: "aoc4")
        
        print(Day4.countCards())
    }

    func DISABLEDtestDay5() throws{
        let testData = Day5.parseData("aoc5")
        let seedRanges = Day5.getSeedRanges(testData)
//        print("Initial seed Ranges: ", seedRanges)
        print("Part 1 solution:", Day5.findLowestSeedPart1(testData))
        print("Part 2 solution: ", Day5.part2(seedRanges: seedRanges, testData: testData))
    }
    
    func testDay6() throws{
        let data = Day6.getData("aoc6")
        print(Day6.part1(data))
        let data2 = Day6.Race(time: 38947970, distance: 241154910741091)
        print(Day6.part1([data2]))
    }

}
