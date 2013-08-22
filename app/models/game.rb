class Game < ActiveRecord::Base
  has_one :current_player, :class_name => 'Player'
  has_one :other_player, :class_name => 'Player'

  accepts_nested_attributes_for :current_player

  attr_accessor :action

  def action=(action)
    # player has chosen to do `action`
  end
end
