//
//  AdventOfCodeTests.swift
//  AdventOfCodeTests
//
//  Created by Peter Hartnett on 12/3/23.
//

import XCTest
@testable import AdventOfCode

final class AdventOfCodeTests: XCTestCase {


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
    
    func DISABLEDtestDay6() throws{
        let data = Day6.getData("aoc6")
        print(Day6.part1(data))
        let data2 = Day6.Race(time: 38947970, distance: 241154910741091)
        print(Day6.part1([data2]))
    }
    
    func testDay7() throws{
        let cards = Day7.getCards("aoc7")
        let cardsJackWild = Day7.getCards("aoc7", jackIsWild: true)
        let part1 = Day7.getTotalWinnings(cards: cards)
        print("Day 7 Part 1: ", part1)
        XCTAssertEqual(part1, 253933213, "Part 1 should be 253933213, currently: \(part1)")
        let part2 = Day7.getTotalWinnings(cards: cardsJackWild)
        print("Day 7 part 2: ", part2)
        XCTAssertEqual(part2, 253473930, "Part2 should be 253473930, currently: \(part2)")
    }

}
