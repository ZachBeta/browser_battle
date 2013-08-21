class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :game_id
      t.integer :rock_health
      t.integer :paper_health
      t.integer :scissor_health
      t.string :current_monster

      t.timestamps
    end
  end
end
