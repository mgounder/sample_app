# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  #Listing 10.11 A user has_many microposts
  #Listing 10.16 Ensuring that a user's microposts are destryed along with the user.
  has_many :microposts, dependent: :destroy
  #Listing 11.4 Implementing the user/relationships has_many association
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  #Listing 11.10 Adding the User model followed_users association
  has_many :followed_users, through: :relationships, source: :followed
  #Listing 11.16 Implementing user.followers using reverse relatinships
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  before_save { self.email.downcase! }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  #Listing 10.39 A preliminary implementation for the micropost status feed
  #? below is to escape the id before inclusion in the SQL query.
  #Should always escape variables for SQL queries in this way to avoid SQL injection security hole.
  def feed
    #Updated with Listing 11.42 adding the completed feed to the User model
    Micropost.from_users_followed_by(self)
  end
  
  #Listing 11.12 The following? and follow! utility methods.
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  
  #Listing 11.14 Unfollowing a user by destroying a user relationship
  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end
  
  private
  
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
