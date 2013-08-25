require 'spec_helper'

describe Player do
  describe '#current_monster_health' do
    it 'provides the current monsters health' do
      player = Player.new
      player.current_monster_health.should == 50
    end
  end
end
