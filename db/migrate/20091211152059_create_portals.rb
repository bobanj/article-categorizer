class CreatePortals < ActiveRecord::Migration
  def self.up
    create_table :portals do |t|
      t.string :name
      t.string :hostname
      t.timestamps
    end
    add_index :portals, :id
  end
  
  def self.down
    remove_index :portals, :id
    drop_table :portals
  end
end
