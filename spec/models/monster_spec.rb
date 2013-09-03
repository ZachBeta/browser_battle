require 'spec_helper'

describe Monster do
  describe "attack" do
    it "damages target monster" do
      attacking_monster = Monster.new
      target_monster = Monster.new(:health => 9000)

      attacking_monster.attack!(target_monster)
      target_monster.health.should < 9000
    end
    it "kills target monster" do
      attacking_monster = Monster.new
      target_monster = Monster.new(:health => 0)

      attacking_monster.attack!(target_monster)
      target_monster.health.should == 0
      target_monster.status.should == "ko"
    end
    pending "is ineffective" do

    end
    pending "is super effective" do

    end
    pending "misses" do

    end
    pending "backfires" do

    end
  end
end
