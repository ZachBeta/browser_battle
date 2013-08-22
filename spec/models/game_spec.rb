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
end
