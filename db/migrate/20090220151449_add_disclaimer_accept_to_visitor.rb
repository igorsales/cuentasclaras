class AddDisclaimerAcceptToVisitor < ActiveRecord::Migration
  def self.up
    add_column :visitors, :accept_disclaimer, :boolean
  end

  def self.down
    remove_column :visitors, :accept_disclaimer
  end
end
