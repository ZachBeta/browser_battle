require 'spec_helper'

describe Player do
  describe '#current_monster_health' do
    it 'provides the current monsters health' do
      player = Player.new(:rock_health => 42, :current_monster => 'rock')
      player.current_monster_health.should == 42
    end
  end
end
