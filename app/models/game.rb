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

  def handle_action(params)
    action = params[:action]
    new_monster_id = params[:switch_monster]

    unless action == 'create'
      current_player_monster = current_player.current_monster
      other_player_monster = other_player.current_monster

      if action == 'attack'
        results = current_player_monster.attack!(other_player_monster)
        @notice_message = results[:message]
      elsif action == 'switch'
        new_monster = current_player.monsters.where(:id => new_monster_id).first
        if new_monster
          current_monster = current_player.current_monster
          current_monster.status = 'waiting'
          current_monster.save

          new_monster.status = 'active'
          new_monster.save
          @notice_message = "switched to #{new_monster.monster_type}"
        else
          @notice_message = "That monster doesn't exist for player #{current_player.id}, turn skipped :-("
        end
      end

      switch_players_and_save!
      # player has chosen to do `action`
    end
  end

  def notice_message
    @notice_message ||= 'Game updated, yo!'
  end

end
