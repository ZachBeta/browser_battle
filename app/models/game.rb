class Game < ActiveRecord::Base
  belongs_to :player_one, :class_name => 'Player'
  belongs_to :player_two, :class_name => 'Player'
  belongs_to :current_player, :class_name => 'Player'
  belongs_to :other_player, :class_name => 'Player'

  accepts_nested_attributes_for :current_player
  accepts_nested_attributes_for :other_player

  attr_accessor :action, :switch_monster

  def switch_players_and_save!
    player = current_player
    self.current_player= other_player
    self.other_player= player
    save
  end

  def self.new_with_defaults(game_params = nil)
    game = Game.new(game_params)
    game.current_player = Player.new
    game.player_one = game.current_player
    game.other_player = Player.new
    game.player_two = game.other_player

    game.players.each do |player|
      player.build_default_monsters
    end

    game
  end

  def players
    [player_one, player_two]
  end

  def handle_action(params)
    action = params[:action]
    new_monster_id = params[:switch_monster]
    unless action == 'create'
      if action == 'attack'
        results = current_player.attack!(other_player)
        @notice_message = results[:message]
      elsif action == 'switch'
        results = current_player.switch_monsters!(new_monster_id)
        @notice_message = results[:message]
      end

      switch_players_and_save!
      # player has chosen to do `action`
    end
  end

  def notice_message
    @notice_message ||= 'Game updated, yo!'
  end

  def over?
    player_one.has_lost? || player_two.has_lost?
  end

  def loser
    if player_one.has_lost?
      player_one
    elsif player_two.has_lost?
      player_two
    else
      nil
    end
  end

  def winner
    if player_one.has_lost?
      player_two
    elsif player_two.has_lost?
      player_one
    else
      nil
    end
  end

  def current_monster_is_ko?
    current_player.current_monster_is_ko?
  end

  def current_monster
    current_player.current_monster
  end

  def other_monster
    other_player.current_monster
  end
end
