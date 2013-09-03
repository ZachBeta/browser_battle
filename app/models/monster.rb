class Monster < ActiveRecord::Base
  default_scope { order('created_at DESC') }

  def attack!(target_monster)
    damage = calculate_roll_damage(target_monster)
    if damage >= target_monster.health
      # TODO check for target_monster having 0 health
      target_monster.health = 0
      target_monster.status = "ko"
    else
      target_monster.health -= damage
    end
    target_monster.save

    { :message => "#{monster_type} attacked #{target_monster.monster_type} for #{damage} damage. Damage modifier: #{damage_modifier(target_monster)}" }
  end

  def is_ko?
    status == 'ko'
  end

  def calculate_roll_damage(target_monster)
    roll = rand(20)
    damage = roll * damage_modifier(target_monster)
    damage.floor
  end

  def damage_modifier(target_monster)
    if monster_type == 'rock' && target_monster.monster_type == 'rock'
      1
    elsif monster_type == 'rock' && target_monster.monster_type == 'paper'
      0.75
    elsif monster_type == 'rock' && target_monster.monster_type == 'scissors'
      1.25
    elsif monster_type == 'paper' && target_monster.monster_type == 'rock'
      1.25
    elsif monster_type == 'paper' && target_monster.monster_type == 'paper'
      1
    elsif monster_type == 'paper' && target_monster.monster_type == 'scissors'
      0.75
    elsif monster_type == 'scissors' && target_monster.monster_type == 'rock'
      0.75
    elsif monster_type == 'scissors' && target_monster.monster_type == 'paper'
      1.25
    elsif monster_type == 'scissors' && target_monster.monster_type == 'scissors'
      1
    else
      1
    end
  end
end
