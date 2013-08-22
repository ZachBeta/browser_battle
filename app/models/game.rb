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

  def build_players
    player_defaults = { :rock_health => 50, :paper_health => 50, :scissor_health => 50, :current_monster => 'rock' }
    build_current_player(player_defaults)
    build_other_player(player_defaults)
  end

  def players
    [current_player, other_player]
  end

  def action=(action)
    # player has chosen to do `action`
  end
end
