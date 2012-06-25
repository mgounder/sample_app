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
  
  #Listing 11.43 A first cut at the from_user_follwed_by method
  #Then refactored based on Listing 11.44 to improve from_user_followed_by efficiency
  #The completed with Listing 11.45
  #Returns microposts from the users being followed by the given user.
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
  end
end
