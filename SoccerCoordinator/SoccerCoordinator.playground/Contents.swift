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
var teamsHeights: [[Int]] = [ [], [], [] ] // This extra list of just the teams heights is used for averaging later
// ------------------------------------------------------------------------------------------


// Create two 2D arrays to hold player info sorted into "experienced" and "inexperienced" sets.
// ------------------------------------------------------------------------------------------
var experiencedPlayers: [[Any]]  = []
var inexperiencedPlayers: [[Any]]  = []
// ------------------------------------------------------------------------------------------


// Iterate over "players" array and append each player into "experienced" and "inexperienced" lists.
// ------------------------------------------------------------------------------------------
for player in players {
    if (player[2] as! Bool) {
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
 The GOAL is to have n number of teams with roughly equal experience level and average height.
 The LOGIC is as follows:
    - Since "teams" arrays start out empty, first append the next unused value from "experiencedPlayers" to each list
    - Append all remaining pre-sorted values into a single array called "playersSortedIntoOneArray". This array already
      contains equal experienced and inexperienced players ranked in descending order by height.
    - Finally, append each unassigned player to a team, reverseing the order of the "teams" array each time a player is
      added so that the players heights stay uniform among all the teams.
 */

var unassignedPlayers: [Any] = []
var listOfTeamAverageHeights: [Int] = []

for x in 0..<teams.count {                                          // Iterate over a range equal to the number of teams.
    
    teams[x].append(experiencedPlayersSorted[0])                    // For each subarray, append the first value of
                                                                    //     "experiencedPlayersSorted"
    teamsHeights[x].append(experiencedPlayersSorted[0][1] as! Int)  // Add just the heights to a list for averaging later
    
    experiencedPlayersSorted.remove(at: 0)                          // As each player is assigned, romove that player from
                                                                    //     "experiencedPlayersSorted".
}
// ------------------------------------------------------------------------------------------



// Put all the remaining players together in one list.
// ------------------------------------------------------------------------------------------
for player in experiencedPlayersSorted { unassignedPlayers.append(player) }
for player in inexperiencedPlayersSorted { unassignedPlayers.append(player) }
// ------------------------------------------------------------------------------------------


/* Read over the remaining (unassigned) players in "unassignedPlayers" and assign each player to a team.

     NOTE: In line 100 we reverse the order of the teams in the "teams" array each time a player is added to any
     team so that player heights are distributed uniformly

 */
// ------------------------------------------------------------------------------------------

for x in 0..<unassignedPlayers.count {
  teams = teams.reversed()
  teams[x % teams.count].append(unassignedPlayers[x])
}
// ------------------------------------------------------------------------------------------



print("TEAM ONE:")
print(teams[0])
print(" ")
print("TEAM TWO:")
print(teams[1])
print(" ")
print("TEAM THREE:")
print(teams[2])






//listOfTeamAverageHeights.removeAll()                           // Clear the averages array

//for teamHeight in teamsHeights {                               // Make a list of the average heights for each team
    //listOfTeamAverageHeights.append((teamHeight.reduce(0, +)) / teamHeight.count)
//}

//let indx = (listOfTeamAverageHeights.index(of: listOfTeamAverageHeights.max() as! Int) as! Int) // Get the index of the shortest team.

//teams[indx].append(playersSortedIntoOneArray[x])
//teamsHeights[indx].append(experiencedPlayersSorted[0][1] as! Int)

//sorted(teams, key=len)









