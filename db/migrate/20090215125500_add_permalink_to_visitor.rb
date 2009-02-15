class AddPermalinkToVisitor < ActiveRecord::Migration
  def self.up
    add_column :visitors, :permalink, :string
  end

  def self.down
    remove_column :visitors, :permalink
  end
end
