class AddPermalinkToBill < ActiveRecord::Migration
  def self.up
    add_column :bills, :permalink, :string
  end

  def self.down
    remove_column :bills, :permalink
  end
end
