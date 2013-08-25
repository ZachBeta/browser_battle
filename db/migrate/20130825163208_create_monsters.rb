class CreateMonsters < ActiveRecord::Migration
  def change
    create_table :monsters do |t|
      t.integer :player_id
      t.string :type
      t.integer :health

      t.timestamps
    end

    remove_column :players, :rock_health
    remove_column :players, :paper_health
    remove_column :players, :scissor_health
    remove_column :players, :current_monster
    add_column :players, :current_monster_id, :integer
  end
end
