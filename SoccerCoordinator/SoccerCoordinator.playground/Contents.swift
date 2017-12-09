import UIKit

// A 2D array is used to hold all player info.
// Each index spot in "players" array contains an array listing that player's name, height, experience (as a bool) and guardians name/s.
let players: [[Any]]  = [
    ["Joe Smith", 42, true, "Jim and Jan Smith"],
    ["Jill Tanner", 36, true, "Clara Tanner"],
    ["Bill Bon", 43, true, "Sara and Jenny Bon"],
    ["Eva Gordon", 45, false, "Wendy and Mike Gordon"],
    ["Matt Gill", 40, false, "Charles and Sylvia Gill"],
    ["Kimmy Stein", 41, false, "Bill and Hillary Stein"],
    ["Sammy Adams", 45, false, "Jeff Adams"],
    ["Karl Saygan", 42, true, "Heather Bledsoe"],
    ["Suzane Greenberg", 44, true, "Henrietta Dumas"],
    ["Sal Dali", 41, false, "Gala Dali"],
    ["Joe Kavalier", 39, false, "Sam and Elaine Kavalier"],
    ["Ben Finkelstein", 44, false, "Aaron and Jill Finkelstein"],
    ["Diego Soto", 41, true, "Robin and Sarika Soto"],
    ["Chloe Alaska", 47, false, "David and Jamie Alaska"],
    ["Arnold Willis", 43, false, "Claire Willis"],
    ["Phillip Helm", 44, true, "Thomas Helm and Eva Jones"],
    ["Les Clay", 42, true, "Wynonna Brown"],
    ["Herschel Krustofski", 45, true, "Hyman and Rachel Krustofski"],
]


// This 2D array contains the teams to which players will be assigned. Any number of teams are possible.
// ------------------------------------------------------------------------------------------
var teams: [[Any]] = [ [], [], [] ]
let teamNames: [String] = ["Dragons", "Sharks", "Raptors"]
let practiceDates: [String] = ["March 17 at 1pm", "March 17 at 3pm", "March 18 at 1pm"]
var teamsHeights: [Float] = [] // This extra list of just the teams heights is used for averaging later
// ------------------------------------------------------------------------------------------


// Create two 2D arrays to hold player info sorted into "experienced" and "inexperienced" sets.
// ------------------------------------------------------------------------------------------
var experiencedPlayers: [[Any]]  = []
var inexperiencedPlayers: [[Any]]  = []
// ------------------------------------------------------------------------------------------


// Iterate over "players" array and append each player into "experienced" and "inexperienced" lists.
// ------------------------------------------------------------------------------------------
for player in players {
    if (player[2] as! Bool) {              // We get just the player's experience data, as a boolean, from each player's array.
        experiencedPlayers.append(player)
    }
    else {
        inexperiencedPlayers.append(player)
    }
}
// ------------------------------------------------------------------------------------------


// Sort both "experiencedPlayers" and "inexperiencedPlayers" in decending order by height
var experiencedPlayersSorted: [[Any]] = experiencedPlayers.sorted { ($0[1] as! Int) > ($1[1] as! Int) }
var inexperiencedPlayersSorted: [[Any]] = inexperiencedPlayers.sorted { ($0[1] as! Int) > ($1[1] as! Int) }

 /*
 The GOAL is to have n-number of teams with roughly equal experience level and average height varying not more than 1.5in.
 The LOGIC is as follows:
    - Append the two pre-sorted "experienced" and "inexperienced" player arrays into a single array called "unassignedPlayers".
         This array already contains equal experienced and inexperienced players ranked in descending order by height (see
         lines 55 and 56).
    - Then, append each unassigned player to a team, reverseing the order of the teams in the "teams" array each time anplayer
         is added so that the players heights stay uniform among all the teams.
 */

var unassignedPlayers: [Any] = []

// Put all the players together in one list.
// ------------------------------------------------------------------------------------------
for player in experiencedPlayersSorted { unassignedPlayers.append(player) }
for player in inexperiencedPlayersSorted { unassignedPlayers.append(player) }
// ------------------------------------------------------------------------------------------


/* For loop read over the remaining (unassigned) players in "unassignedPlayers" and assign each player to a team.

     NOTE: In line 85 we reverse the order of the teams in the "teams" array each time a player is added to any
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

for x in 0..<teams.count {
    print("---- TEAM #\(x+1) ----")
    
    let oneTeam: [Any] = teams[x] // oneTeam is just whichever of the teams we've pulled from "teams" in line 94
    var aTeamsHeights: [Int] = []
    for x in 0..<oneTeam.count {
        let playerInfo: [Any] = oneTeam[x] as! [Any]
        aTeamsHeights.append(playerInfo[1] as! Int)
    }
    teamsHeights.append((Float(aTeamsHeights.reduce(0, +)) / Float(aTeamsHeights.count)))
    
    print("(team #\(x+1)'s average height is \(Float(aTeamsHeights.reduce(0, +)) / Float(aTeamsHeights.count)) inches.)")
    print(" ")
    for player in oneTeam {
        print("- \(player)")
    }
    print(" ")
    print("-----------------")
    print(" ")
    print(" ")
    
}
// ------------------------------------------------------------------------------------------

// get the distance between min and max average heights:
let teamsHeightsRange: Float = ((teamsHeights.max() as! Float) - (teamsHeights.min() as! Float))

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
        aTeamsNames.append(playerInfo[0] as! String)
        aTeamsHeights.append(playerInfo[1] as! Int)
        aTeamsExperience.append(playerInfo[2] as! Bool)
        aTeamsGuardians.append(playerInfo[3] as! String)
    }
    
    for x in 0..<oneTeam.count {
        let childName: String = aTeamsNames[x]
        let guardian: String = aTeamsGuardians[x]
        letters[dictCounter] = "Dear \(guardian): \n\nI am writing today to let you know that \(childName) has been assigned to team \(teamNames[teamNumber]). Each team has been carefully \nsellected to reprosent a uniform distribution of prior athletic experience and ability accross all teams in the league. \nAdditionally, the average height of all teams in the league has been kept within a range of \(teamsHeightsRange) inches. For team \n\(teamNames[teamNumber]), the first practice of the season will take place on \(practiceDates[teamNumber]). \n\nBest regards, \nYour Robot Overloard \n\n\n"
        dictCounter += 1
    }
}


// Print all letters from the dictionary "letters."
// ------------------------------------------------------------------------------------------
for x in 0..<letters.count {
        print(letters[x] as! String)
}
// ------------------------------------------------------------------------------------------
