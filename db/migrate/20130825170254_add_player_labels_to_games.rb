class AddPlayerLabelsToGames < ActiveRecord::Migration
  def change
    add_column :games, :player_one_id, :integer
    add_column :games, :player_two_id, :integer
  end
end
