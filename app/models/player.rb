class Player < ActiveRecord::Base
  has_many :monsters

  def current_monster_health
    current_monster.health
  end

  def build_default_monsters
    self.monsters.build(:monster_type => 'rock', :health => 50, :status => 'active')
    self.monsters.build(:monster_type => 'paper', :health => 50, :status => 'waiting')
    self.monsters.build(:monster_type => 'scissors', :health => 50, :status => 'waiting')
  end

  def current_monster
    monsters.where(:status => 'active').limit(1).first
  end

  def current_monster_is_ko?
    current_monster.nil?
    # FIXME: ought to be something like...
    # current_monster && current_monster.is_ko?
    # but right now current monster nils out once it goes KO
  end

  def available_monsters
    monsters.where(:status => 'waiting')
  end

  def switch_monsters!(new_monster_id)
    old_monster = current_monster
    new_monster = monsters.where(:id => new_monster_id).first

    if old_monster
      old_monster.status = 'waiting'
      old_monster.save
    end

    if new_monster
      new_monster.status = 'active'
      new_monster.save

      return { :message => "switched to #{new_monster.monster_type}" }
    else
      return { :message => "That monster doesn't exist for player #{current_player.id}, turn skipped :-(" }
    end
  end

  def attack!(other_player)
    if current_monster
      current_monster.attack!(other_player.current_monster)
    else
      switch_monsters!(available_monsters.first.id)
      { :message => "Can't attack, that monster is ko'd. Automatically switched to #{current_monster.monster_type}" }
    end
  end

  def has_lost?
    monsters.where(:status => 'ko').count == monsters.count
  end
end
