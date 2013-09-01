    # TODO:
    # things to figure out
    # who should know about a monster being dead?
    # how should turns be handled? a game probably isn't the best for that, maybe a game turn?
    # feels like test coverage is still low
    # this handle action method knows too much
    # a player should not be able to switch to a monster if it's dead
    # monsters should deal weighted damage
    #
    #
    # controller - route the params to the right place
    # model - persist data and handle relationships
    # service object - handle multiple objects together
    # game
    #   switch monsters
    #     blow up if monster is dead
    #   attack monster
    #     blow up if monster is dead
    #



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
