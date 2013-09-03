require 'spec_helper'

describe Game do
  describe '#switch_players' do
    pending 'should change current and other player' do
      game = Game.new
      game.build_players
      current_player = game.current_player
      other_player = game.other_player

      game.switch_players!

      game.current_player.should == other_player
      game.other_player.should == current_player
    end
  end

  describe '#roll_damage' do
    context 'given a rock against a scissor' do
      it 'pends'
    end
  end

  describe '#action=' do
    context 'attack' do
      pending 'attacks other players current monster' do
        game = Game.new
        game.build_players
        previous_health = game.other_player.rock_health
        game.action = 'attack'
        current_health = game.other_player.rock_health

        current_health.should <= previous_health
      end
    end
  end
  describe 'pre action' do
    it 'handles a game loss/victory' do
      # Player 1 attacks player 2, knocks out player 2's current monster
      # At start of player 2's turn, they must select a new active monster to continue
      # Each turn has (at least) 3 phases - pre-action, action, and post-action
      # Pre-action: set up view, ensure that player is capable of acting (e.g. select replacement monster if previous monster was ko'd)
      # Action: attack/switch/?
      # Post-action: check for victory conditions
      game = Game.new_with_defaults
      winning_player = game.player_one
      losing_player = game.player_two
      losing_player.monsters.each do |monster| monster.status = "ko" end
      game.save!

      game.over?.should == true
      game.winner.should == winning_player
      game.loser.should == losing_player
    end
  end
end
