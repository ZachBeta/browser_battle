class Game < ActiveRecord::Base
  belongs_to :player_one, :class_name => 'Player'
  belongs_to :player_two, :class_name => 'Player'
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
    if action == 'attack'
      damage = roll_damage
      @notice_message = "Player #{current_player.id} attacked Player #{other_player.id} for #{damage} damage"
      other_player.current_monster.health -= damage
      other_player.current_monster.save
      switch_players!
      save
    end
    # player has chosen to do `action`
  end

  def notice_message
    @notice_message ||= 'Game updated, yo!'
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
