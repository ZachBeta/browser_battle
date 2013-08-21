# Version 0

Game
current_player:integer
player_one_health:integer
player_two_health:integer

Pick one to go first
Each rolls a d20
If roll is 1 deal self 5 damage
If roll is 20 deal 25 damage
Else deal roll damage


# Version 1

Game
current_player:integer

Player
game_id:integer
position:integer # 1 or 2
bird_health:integer # 50
stone_health:integer # 50
water_health:integer # 50
current_monster:string


Player chooses
1- Change monster (any other living monsters)
2- Attack

Form submit

# Version 2

Game

Attacks
Log attacks

4 Monsters per Player
Fire ov Air
Fire eq Water
Fire un Earth

Air ov Water
Air eq Earth
Air un Fire

Water ov Earth
Water eq Fire
Water un Air

Earth ov Fire
Earth eq Air
Earth un Water

Players (users)
Allow to create a null user and session without logging in
Allow ability to persist and add to a leaderboard

Scores
