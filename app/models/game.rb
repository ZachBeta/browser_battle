class Game < ActiveRecord::Base
  belongs_to :current_player, :class_name => 'Player'
  belongs_to :other_player, :class_name => 'Player'

  accepts_nested_attributes_for :current_player
  accepts_nested_attributes_for :other_player

  attr_accessor :action

  def switch_players!
    player = current_player
    self.current_player= other_player
    self.other_player= player
  end

  # handle player 1 and player 2 for view

  def build_players
    player_defaults = { :rock_health => 50, :paper_health => 50, :scissor_health => 50, :current_monster => 'rock' }
    build_current_player(player_defaults)
    build_other_player(player_defaults)
  end

  def players
    [current_player, other_player]
  end

  def action=(action)
    if action == 'attack'
      other_player.rock_health -= roll_damage
      switch_players!
      save
    end
    # player has chosen to do `action`
  end

  def roll_damage
    roll = rand(20)
    # if roll == 20
    #   damage = 25
    # end
    damage = roll * damage_modifier
    damage
  end

  def damage_modifier
    if current_player.current_monster == 'rock' && other_player.current_monster == 'rock'
      1
    elsif current_player.current_monster == 'rock' && other_player.current_monster == 'paper'
      0.75
    elsif current_player.current_monster == 'rock' && other_player.current_monster == 'scissors'
      1.25
    elsif current_player.current_monster == 'paper' && other_player.current_monster == 'rock'
      1.25
    elsif current_player.current_monster == 'paper' && other_player.current_monster == 'paper'
      1
    elsif current_player.current_monster == 'paper' && other_player.current_monster == 'scissors'
      0.75
    elsif current_player.current_monster == 'scissors' && other_player.current_monster == 'rock'
      0.75
    elsif current_player.current_monster == 'scissors' && other_player.current_monster == 'paper'
      1.25
    elsif current_player.current_monster == 'scissors' && other_player.current_monster == 'scissors'
      1
    else
      1
    end
  end
end
