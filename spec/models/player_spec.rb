require 'spec_helper'

describe Player do
  describe '#current_monster_health' do
    it 'provides the current monsters health' do
      player = Player.new
      player.build_default_monsters
      player.save
      player.current_monster_health.should == 50
    end
  end

  describe '#switch_monsters!' do
    context 'given an active current monster' do
      it 'switches the current monster to waiting and the new monster to active' do
        player = Player.new
        player.save
        previous_monster = player.monsters.create(:status => 'active')
        switching_monster = player.monsters.create

        player.switch_monsters!(switching_monster.id)

        player.current_monster.should == switching_monster
        Monster.find(previous_monster.id).status.should_not == 'active'
        Monster.find(switching_monster.id).status.should == 'active'
      end
    end
  end

  describe '#has_lost?' do
    context 'player has all monsters ko' do
      it 'returns true' do
        player = Player.new
        player.build_default_monsters
        player.monsters.each do |monster|
          monster.status = 'ko'
        end

        player.has_lost?.should == true
      end
    end
  end
end
