class VisitorBill < ActiveRecord::Base
  validates_uniqueness_of :bill_id
  validates_uniqueness_of :visitor_id
end
