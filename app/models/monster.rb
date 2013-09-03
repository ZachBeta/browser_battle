class Monster < ActiveRecord::Base
  default_scope { order('created_at DESC') }

  def attack!(target_monster)
    damage = calculate_roll_damage
    if damage >= target_monster.health
      # TODO check for target_monster having 0 health
      target_monster.health = 0
      target_monster.status = "ko"
    else
      target_monster.health -= damage
    end
    target_monster.save

    { :message => "Attacked for #{damage} damage" }
  end

  def calculate_roll_damage
    roll = rand(20)
    damage = roll * damage_modifier
    damage
  end

  def damage_modifier
    1
  end

  # def damage_modifier
  #   if current_player.current_monster == 'rock' && other_player.current_monster == 'rock'
  #     1
  #   elsif current_player.current_monster == 'rock' && other_player.current_monster == 'paper'
  #     0.75
  #   elsif current_player.current_monster == 'rock' && other_player.current_monster == 'scissors'
  #     1.25
  #   elsif current_player.current_monster == 'paper' && other_player.current_monster == 'rock'
  #     1.25
  #   elsif current_player.current_monster == 'paper' && other_player.current_monster == 'paper'
  #     1
  #   elsif current_player.current_monster == 'paper' && other_player.current_monster == 'scissors'
  #     0.75
  #   elsif current_player.current_monster == 'scissors' && other_player.current_monster == 'rock'
  #     0.75
  #   elsif current_player.current_monster == 'scissors' && other_player.current_monster == 'paper'
  #     1.25
  #   elsif current_player.current_monster == 'scissors' && other_player.current_monster == 'scissors'
  #     1
  #   else
  #     1
  #   end
  # end
end
