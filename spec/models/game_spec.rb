require 'spec_helper'

describe Game do
  describe '#switch_players' do
    it 'should change current and other player' do
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
      it 'attacks other players current monster' do
        game = Game.new
        game.build_players
        previous_health = game.other_player.rock_health
        game.action = 'attack'
        current_health = game.other_player.rock_health

        current_health.should <= previous_health
      end
    end
  end
end
