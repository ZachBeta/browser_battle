class ChangeTypeOnMonsters < ActiveRecord::Migration
  def change
    rename_column :monsters, :type, :monster_type
  end
end
