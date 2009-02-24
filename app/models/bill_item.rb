class BillItem < ActiveRecord::Base
  belongs_to :bill
  belongs_to :bill_participant
  has_many   :bill_payments
  
  validates_presence_of :name
end
