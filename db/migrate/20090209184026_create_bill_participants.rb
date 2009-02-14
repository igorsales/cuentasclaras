class CreateBillParticipants < ActiveRecord::Migration
  def self.up
    create_table :bill_participants do |t|
      t.string :name
	  
	  # Foreign keys
	  t.integer :bill_id

      t.timestamps
    end
  end

  def self.down
    drop_table :bill_participants
  end
end
