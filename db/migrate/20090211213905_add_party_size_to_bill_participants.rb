class AddPartySizeToBillParticipants < ActiveRecord::Migration
  def self.up
    add_column :bill_participants, :party_size, :integer
  end

  def self.down
    remove_column :bill_participants, :party_size
  end
end
