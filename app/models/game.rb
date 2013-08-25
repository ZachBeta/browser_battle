class Game < ActiveRecord::Base
  belongs_to :player_one, :class_name => 'Player'
  belongs_to :player_two, :class_name => 'Player'
  belongs_to :current_player, :class_name => 'Player'
  belongs_to :other_player, :class_name => 'Player'

  accepts_nested_attributes_for :current_player
  accepts_nested_attributes_for :other_player

  attr_accessor :action

  def switch_players_and_save!
    player = current_player
    self.current_player= other_player
    self.other_player= player
    save
  end

  # TODO: handle player 1 and player 2 for view
  #
  def self.new_with_defaults(game_params = nil)
    game = Game.new(game_params)
    game.current_player = Player.new
    game.player_one = game.current_player
    game.other_player = Player.new
    game.player_two = game.other_player

    game.players.each do |player|
      player.monsters.build(:monster_type => 'rock', :health => 50, :status => 'active')
      player.monsters.build(:monster_type => 'paper', :health => 50)
      player.monsters.build(:monster_type => 'scissors', :health => 50)
    end

    game
  end

  def players
    [player_one, player_two]
  end

  def action=(action)
    current_player_monster = current_player.current_monster
    other_player_monster = other_player.current_monster

    if action == 'attack'
      current_player_monster.attack!(other_player_monster)
      switch_players_and_save!
    end
    # player has chosen to do `action`
  end

  def notice_message
    @notice_message ||= 'Game updated, yo!'
  end

end
