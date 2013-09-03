class Player < ActiveRecord::Base
  has_many :monsters

  def current_monster_health
    current_monster.health
  end

  def build_default_monsters
    self.monsters.build(:monster_type => 'rock', :health => 50, :status => 'active')
    self.monsters.build(:monster_type => 'paper', :health => 50)
    self.monsters.build(:monster_type => 'scissors', :health => 50)
  end

  def current_monster
    monsters.where(:status => 'active').limit(1).first
  end

  def switch_monsters!(new_monster_id)
    old_monster = current_monster
    new_monster = monsters.where(:id => new_monster_id).first
    if new_monster
      old_monster.status = 'waiting'
      old_monster.save

      new_monster.status = 'active'
      new_monster.save

      return { :message => "switched to #{new_monster.monster_type}" }
    else
      return { :message => "That monster doesn't exist for player #{current_player.id}, turn skipped :-(" }
    end
  end

  def attack!(other_player)
    current_monster.attack!(other_player.current_monster)
  end

  def has_lost?
    monsters.where(:status => 'ko').count == monsters.count
  end
end
