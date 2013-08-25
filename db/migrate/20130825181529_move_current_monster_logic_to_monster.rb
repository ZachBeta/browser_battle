class MoveCurrentMonsterLogicToMonster < ActiveRecord::Migration
  def change
    remove_column :players, :current_monster_id
    add_column :monsters, :status, :string
  end
end
