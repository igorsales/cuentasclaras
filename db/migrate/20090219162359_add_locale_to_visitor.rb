class AddLocaleToVisitor < ActiveRecord::Migration
  def self.up
    add_column :visitors, :locale, :string
  end

  def self.down
    remove_column :visitors, :locale
  end
end
