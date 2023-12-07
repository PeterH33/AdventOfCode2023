//
//  day2.swift
//  AdventOfCode
//
//  Created by Peter Hartnett on 12/2/23.
//

import SwiftUI

struct day2View: View {
    let dataSet = Day2()
    var body: some View {
        Text("\(Day2.sumPossibleGameIDS(dataSet: dataSet, redShown:12, greenShown:13, blueShown:14))")
        Text("Part 2: \(Day2.getSumOfPowers(dataSet: dataSet))")
    }
}



struct Game{
    var gameID: Int = 0
    var rounds: [Round] = []
}

struct Round{
    var red: Int = 0
    var green: Int = 0
    var blue: Int = 0
}


struct Day2{
    
    var games: [Game]
    
    init() {
        
        self.games = Day2.parseGames(lines: Day2.getLines())
    }
    
    static func getSumOfPowers(dataSet: Day2) -> Int{
        var returnTotal = 0
        for game in dataSet.games {
            returnTotal += getPowerOfAGame(game: game)
        }
        
        return returnTotal
    }
    
    static func getPowerOfAGame(game: Game) -> Int{
        var currentHighRed = 0
        var currentHighGreen = 0
        var currentHighBlue = 0
        for round in game.rounds{
            if round.red > currentHighRed{
                currentHighRed = round.red
            }
            if round.green > currentHighGreen{
                currentHighGreen = round.green
            }
            if round.blue > currentHighBlue{
                currentHighBlue = round.blue
            }
        }
        return currentHighRed * currentHighGreen * currentHighBlue
    }
    
    static func sumPossibleGameIDS(dataSet: Day2, redShown: Int, greenShown: Int, blueShown: Int) -> Int{
        var totalIDSum = 0
        for game in dataSet.games {
            var gameOK = true
            for round in game.rounds {
                if round.red > redShown || round.green > greenShown || round.blue > blueShown{
                    gameOK = false
                }
            }
            print(game.gameID, gameOK)
            if gameOK{
                totalIDSum += game.gameID
            }
            print(totalIDSum)
        }
        
        return totalIDSum
    }

    
    static func parseGames(lines: [String]) -> [Game]{
        var returnGames:[Game] = []
        
        for line in lines{
            if line != ""{
                var thisGame = Game()
                let idAndGames = line.components(separatedBy: ":")
                thisGame.gameID = Int(idAndGames[0].components(separatedBy: " ")[1]) ?? 0
                let gamesStrings = idAndGames[1].components(separatedBy: ";")
                
                for round in gamesStrings{
                    var thisRound: Round = Round()
                    let colors = round.components(separatedBy: ",")
                    for color in colors{
                        let countAndColor = color.trimmingCharacters(in: .whitespaces).components(separatedBy: " ")
                        switch countAndColor[1] {
                        case "red":
                            thisRound.red = Int(countAndColor[0]) ?? 0
                        case "green":
                            thisRound.green = Int(countAndColor[0]) ?? 0
                        case "blue":
                            thisRound.blue = Int(countAndColor[0]) ?? 0
                        default:
                            var _ = 0
                        }
                    }
                    thisGame.rounds.append(thisRound)
                }
                
                returnGames.append(thisGame)
                print(thisGame.gameID)
            }
        }
        
        
        return returnGames
    }
    
    /// Fetches the stored WordList.txt and puts it into memory as the wordDictionary Set. Should it fail, there is a fatalError that will crash the game.
    static func getLines() -> [String]{
        if let startDictionaryURL = Bundle.main.url(forResource: "aoc2", withExtension: "txt"){
            if let startDictionary = try? String(contentsOf: startDictionaryURL){
                return startDictionary.components(separatedBy: "\n")
            }
        }
        //if the function gets to here, there is a fatal error, kill program
        fatalError("Could not load aoc2.txt from bundle")
    }
}

#Preview {
    day2View()
}
