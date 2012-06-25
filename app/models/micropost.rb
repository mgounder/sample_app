class Micropost < ActiveRecord::Base
  attr_accessible :content
  
  #Listing 10.10 A micropost belongs_to a user
  belongs_to :user
  
  #Listing 10.18 Validation that micropost content is present and no more than 140 characters
  validates :content, presence: true, length: { maximum: 140 }
  
  #Listing 10.4 A validation for the micropost's user_id
  validates :user_id, presence: true
  
  #Listing 10.14 Ordering the microposts with default_scope; DESC is for descending in SQL
  default_scope order: 'microposts.created_at DESC'
end
