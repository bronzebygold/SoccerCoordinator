// Soccer Coordinator - Project #1 for Team Treehouse Techdegree Program
// by Daniel James Miller (completed Dec. 11, 2017)

/* Note: The number of teams to sort players into may be changed by changing the length of the arrays
   in lines 59 - 61.
 */

import UIKit


// ---- FUNCTION DECLARATIONS ----

// This functions takes an array of Ints and returns their average value as a Float
// ------------------------------------------------------------------------------------------
func average(heights: [Int]) -> Float {
    let teamAverage: Float = ( (Float(heights.reduce(0, +))) / Float(heights.count) )
    return teamAverage
}
// ------------------------------------------------------------------------------------------

// This functions find the absolute-value distance between the largest and smalest members of an array of Floats
// ------------------------------------------------------------------------------------------
func range(averageHeights: [Float]) -> Float {
    let variance: Float = abs((averageHeights.max() as! Float) - (averageHeights.min() as! Float))
    return variance
}
// ------------------------------------------------------------------------------------------

// ---- END OF FUNCTIONS ----



// A 2D array is used to hold all player info.
// Each index spot in "players" array contains an array listing that player's name, height, experience (as a bool) and guardians name/s.
let players: [[String: Any]]  = [
    ["playerName": "Joe Smith", "height": 42, "isExperienced": true, "guardians": "Jim and Jan Smith"],
    ["playerName": "Jill Tanner", "height": 36, "isExperienced": true, "guardians": "Clara Tanner"],
    ["playerName": "Bill Bon", "height": 43, "isExperienced": true, "guardians": "Sara and Jenny Bon"],
    ["playerName": "Eva Gordon", "height": 45, "isExperienced": false, "guardians": "Wendy and Mike Gordon"],
    ["playerName": "Matt Gill", "height": 40, "isExperienced": false, "guardians": "Charles and Sylvia Gill"],
    ["playerName": "Kimmy Stein", "height": 41, "isExperienced": false, "guardians": "Bill and Hillary Stein"],
    ["playerName": "Sammy Adams", "height": 45, "isExperienced": false, "guardians": "Jeff Adams"],
    ["playerName": "Karl Saygan", "height": 42, "isExperienced": true, "guardians": "Heather Bledsoe"],
    ["playerName": "Suzane Greenberg", "height": 44, "isExperienced": true, "guardians": "Henrietta Dumas"],
    ["playerName": "Sal Dali", "height": 41, "isExperienced": false, "guardians": "Gala Dali"],
    ["playerName": "Joe Kavalier", "height": 39, "isExperienced": false, "guardians": "Sam and Elaine Kavalier"],
    ["playerName": "Ben Finkelstein", "height": 44, "isExperienced": false, "guardians": "Aaron and Jill Finkelstein"],
    ["playerName": "Diego Soto", "height": 41, "isExperienced": true, "guardians": "Robin and Sarika Soto"],
    ["playerName": "Chloe Alaska", "height": 47, "isExperienced": false, "guardians": "David and Jamie Alaska"],
    ["playerName": "Arnold Willis", "height": 43, "isExperienced": false, "guardians": "Claire Willis"],
    ["playerName": "Phillip Helm", "height": 44, "isExperienced": true, "guardians": "Thomas Helm and Eva Jones"],
    ["playerName": "Les Clay", "height": 42, "isExperienced": true, "guardians": "Wynonna Brown"],
    ["playerName": "Herschel Krustofski", "height": 45, "isExperienced": true, "guardians": "Hyman and Rachel Krustofski"],
]


// This 2D array contains the teams to which players will be assigned. Any number of teams are possible.
// ------------------------------------------------------------------------------------------
var teams: [[Any]] = [ [], [], [] ]
let teamNames: [String] = ["Dragons", "Sharks", "Raptors"]
let practiceDates: [String] = ["March 17 at 1pm", "March 17 at 3pm", "March 18 at 1pm"]
var teamsHeights: [Float] = []    // This extra list of just the teams heights is used for averaging later
// ------------------------------------------------------------------------------------------


// Create two 2D arrays to hold player info sorted into "experienced" and "inexperienced" sets.
// ------------------------------------------------------------------------------------------
var experiencedPlayers: [[Any]]  = []
var inexperiencedPlayers: [[Any]]  = []
// ------------------------------------------------------------------------------------------


// Iterate over "players" array and append each player into "experienced" and "inexperienced" lists.
// ------------------------------------------------------------------------------------------
for player in players {
    if (player["isExperienced"] as! Bool) {  // We get just the player's experience data, as a boolean, from each player's array.
        var info: [Any] = []
        for (key, value) in player {
            info.append(value)
        }
        experiencedPlayers.append(info as! [Any])
    }
    else {
        var info: [Any] = []
        for (key, value) in player {
            info.append(value)
        }
        inexperiencedPlayers.append(info as! [Any])
    }
}
// ------------------------------------------------------------------------------------------


// Sort both "experiencedPlayers" and "inexperiencedPlayers" in descending order by height
var experiencedPlayersSorted: [[Any]] = experiencedPlayers.sorted { ($0[2] as! Int) > ($1[2] as! Int) }
var inexperiencedPlayersSorted: [[Any]] = inexperiencedPlayers.sorted { ($0[2] as! Int) > ($1[2] as! Int) }

 /*
 The GOAL is to have n-number of teams with roughly equal experience level and average height varying not more than 1.5in.
 The LOGIC is as follows:
    - Append the two pre-sorted "experienced" and "inexperienced" player arrays into a single array called "unassignedPlayers".
         This array already contains equal experienced and inexperienced players ranked in descending order by height (see
         lines 112 and 113).
    - Then, append each unassigned player to a team, reversing the order of the teams in the "teams" array each time a player
         is added so that the players heights stay uniform among all the teams.
 */

var unassignedPlayers: [Any] = [] // An array to hold any players not yet assigned to teams

// Put all the unassigned players together in one list.
// ------------------------------------------------------------------------------------------
for player in experiencedPlayersSorted { unassignedPlayers.append(player) }
for player in inexperiencedPlayersSorted { unassignedPlayers.append(player) }
// ------------------------------------------------------------------------------------------


/* For loop read over the remaining (unassigned) players in "unassignedPlayers" and assign each player to a team.

     NOTE: In line 125 we reverse the order of the teams in the "teams" array each time a player is added to any
     team so that player heights are distributed uniformly

 */
// ------------------------------------------------------------------------------------------
for x in 0..<unassignedPlayers.count {
  teams = teams.reversed()
  teams[x % teams.count].append(unassignedPlayers[x])
}
// ------------------------------------------------------------------------------------------


// Calculate the average height of each team, and print rosters for the teams (for testing).
// ------------------------------------------------------------------------------------------

print("TEAMS PRINTED HERE FOR TESTING:")
print("Player info order: [isExperienced, playerName, playerHeight, guardiansNames]")
print(" ")
for x in 0..<teams.count {
    let teamNumber: Int = x
    print("---- Team \(teamNames[teamNumber]) ----")
    
    let oneTeam: [Any] = teams[x] // oneTeam is just whichever of the teams we've pulled from "teams" in the for-loop in line 137
    var aTeamsHeights: [Int] = []
    for x in 0..<oneTeam.count {
        let playerInfo: [Any] = oneTeam[x] as! [Any]
        aTeamsHeights.append(playerInfo[2] as! Int)
    }
    teamsHeights.append(average(heights: aTeamsHeights))
    
    print("(team \(teamNames[teamNumber])'s average height is \(average(heights: aTeamsHeights)) inches.)")
    print(" ")
    for player in oneTeam {
        print("- \(player)")
    }
    print(" ")
    print("---------------------")
    print(" ")
    print(" ")
    
}
// ------------------------------------------------------------------------------------------

var letters = [Int: String]() // Declare a dictionary to hold the letters to guardians.

// To write the letter to the childrens' guardians', we first parse the data from the "teams" array for easy access and printing.
// ------------------------------------------------------------------------------------------
var dictCounter: Int = 0
for x in 0..<teams.count {
    let oneTeam: [Any] = teams[x]
    var aTeamsNames: [String] = []
    var aTeamsHeights: [Int] = []
    var aTeamsExperience: [Bool] = []
    var aTeamsGuardians: [String] = []
    let teamNumber: Int = x
    
    for x in 0..<oneTeam.count {
        let playerInfo: [Any] = oneTeam[x] as! [Any]
        aTeamsNames.append(playerInfo[1] as! String)
        aTeamsHeights.append(playerInfo[2] as! Int)
        aTeamsExperience.append(playerInfo[0] as! Bool)
        aTeamsGuardians.append(playerInfo[3] as! String)
    }
    
    for x in 0..<oneTeam.count {
        let childName: String = aTeamsNames[x]
        let guardian: String = aTeamsGuardians[x]
        letters[dictCounter] = "Dear \(guardian): \n\nI am writing today to let you know that \(childName) has been assigned to team \(teamNames[teamNumber]). Each team has been carefully \nselected to represent a uniform distribution of prior athletic experience and ability across all teams in the league. \nAdditionally, the average height of all teams in the league has been kept within a range of \(range(averageHeights: teamsHeights)) inches. For team \n\(teamNames[teamNumber]), the first practice of the season will take place on \(practiceDates[teamNumber]). \n\nBest regards, \nYour Robot Overlord \n\n\n"
        dictCounter += 1
    }
}


// Print all letters from the dictionary "letters."
// ------------------------------------------------------------------------------------------
print("LETTERS TO GUARDIANS")
print("---------------------")
print(" ")
for x in 0..<letters.count {
    print(letters[x] as! String)
}
// ------------------------------------------------------------------------------------------
