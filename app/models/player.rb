class Player < ActiveRecord::Base
  has_many :monsters, :order => 'created_at ASC'

  def current_monster_health
    current_monster.health
  end

  def current_monster
    monsters.where(:status => 'active').limit(1).first
  end
end
