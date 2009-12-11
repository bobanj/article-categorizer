class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :categories, :id
    add_index :articles, :id

  end

  def self.down
    remove_index :categories, :id
    remove_index :articles, :id
  end
end
