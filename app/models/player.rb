class Player < ActiveRecord::Base
  def current_monster_health
    if current_monster == 'rock'
      rock_health
    elsif current_monster == 'paper'
      paper_health
    elsif current_monster == 'scissors'
      scissor_health
    else
      0
    end
  end
end
