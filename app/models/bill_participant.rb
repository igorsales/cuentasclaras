class BillParticipant < ActiveRecord::Base
  belongs_to :bill
  has_many   :bill_items
  has_many   :bill_payments
  
  validates_numericality_of :party_size, :greater_than => 0
end
