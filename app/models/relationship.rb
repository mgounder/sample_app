class Relationship < ActiveRecord::Base
  #Listing 11.6 Adding the belongs_to associations to the Relationship model
  #and removing :follower_id from accessible attributes
  attr_accessible :followed_id
  
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
  #Listing 11.8 Adding the Relationship model validations
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
