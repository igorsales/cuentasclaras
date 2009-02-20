class Visitor < ActiveRecord::Base
  has_and_belongs_to_many :bills, :join_table => :visitor_bills
  validates_uniqueness_of :permalink

  def before_create
    generate_random_permalink
  end
  
private

  def generate_random_permalink
    self.permalink = random_string(16)
  end

  def random_string(len)
    chars = ("a".."z").to_a + ("0".."9").to_a
    new_string = ""
    1.upto(len) { |i| new_string << chars[rand(chars.size-1)] }
    
	new_string
  end
end
