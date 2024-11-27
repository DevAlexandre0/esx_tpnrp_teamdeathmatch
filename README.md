# esx_tpnrp_teamdeathmatch
A mini-game that allow up to 5 players in 1 team (2 team). Similar to CS:GO.

### Require:
- ESX
- [map]/paintball_map (included in [map].zip)
- esx_ambulancejob

## Features
1. Team Management:
- Team Creation: Players can join one of two teams: Blue Team or Red Team.
- Player Team List: Each team has a player list that tracks player information such as name, kills, deaths, and readiness status.
- Max Team Size: The maximum number of players per team is set to 5.
- Team Info Update: Player count and team readiness are updated and communicated to players in real-time.

2. Match Start and Management:
- Match Enable/Disable: The match can be toggled on or off using the /toggleTeamdeathmatch command.
- Match Start Conditions: The match starts once both teams have an equal number of ready players.
- Match Duration: The match proceeds until all players in one team are dead, at which point the opposing team wins.
- Match Rounds: A match consists of multiple rounds, and the first team to reach a specified number of wins (e.g., 3 wins for a Bo3 match) is declared the overall winner.

3. Player Participation:
- Join/Leave Team: Players can join or leave teams as long as the match has not started.
- Ready Status: Players can signal their readiness by setting themselves as "ready." The match can only begin if both teams have all players ready.
- Death and Respawn: Players' death status is tracked, and the match continues until one team has no living members left.
- Match Exit: Players can quit the match at any time by using the /quitmatch command , and their inventory is cleared as they exit.

4. Scoring and Match Conclusion:
- Kills and Deaths Tracking: Each player's kills and deaths are tracked in real-time, along with their streaks (e.g., double kills, triple kills).
- Match Results: Once the match is over, a winner is determined based on team scores and communicated to all players.
- Inventory Management: Players' inventories are saved and restored before and after the match, ensuring that their gear is preserved. Any changes to their inventory during the match are cleared when they leave.
- Revival: Players who die are revived after the match finishes, and their inventory is cleared and reset for the next round.

5. Notifications and Communication:
- Team Notifications: Players receive notifications when they join a team, when they are killed, or when the match starts.
- Match Status Updates: The server broadcasts match status updates to all players, such as when the match is starting, when players die, or when a team wins.
- Voice Alerts: Players hear voice notifications for events like kills, double kills, etc., in real-time.
- Match Feedback: Players are notified of their team's victory or defeat, with a summary of the match score.

6. Inventory and Weapon System:
- Weapon Purchases: Players can purchase weapons and ammo during the match, with the ability to customize weapons based on the type of ammo required.
- Inventory Handling: The script integrates with ox_inventory to manage player items, clear inventories at the start or end of rounds, and restore saved items after rounds are finished.

7. Error and Edge Case Handling:
- Player Dropped Handling: If a player disconnects during a match, their inventory is cleared, and they are removed from the match.
- Team Balance Checking: Before starting the match, the script checks if both teams have an equal number of players. If not, the match will not begin.
- Unfair Team Balancing: If the player count between teams is unbalanced, the match will not start, and players will be notified.

8. Cleanup and Reset:
- Match Reset: At the end of the match, the Deathmatch state is reset, and a new round begins. Player inventories are cleared and reset.
- Post-Match Inventory Reset: After the match ends, player inventories are cleaned up, and they are given a fresh loadout for the next round.

### Contributors:
![Alt text](https://contributors-img.web.app/image?repo=Sn0wBiT/esx_tpnrp_teamdeathmatch)

### Screenshot and Video:
There is no videos. If you have any video please pm me then I'll post it here.

![Alt text](https://github.com/Sn0wBiT/esx_tpnrp_teamdeathmatch/blob/master/screenshot/20190814214434_1.jpg?raw=true)
![Alt text](https://github.com/Sn0wBiT/esx_tpnrp_teamdeathmatch/blob/master/screenshot/20190814214914_1.jpg?raw=true)
![Alt text](https://github.com/Sn0wBiT/esx_tpnrp_teamdeathmatch/blob/master/screenshot/20190814215809_1.jpg?raw=true)
