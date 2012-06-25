#Listing 11.34 The Relationships controller
class RelationshipsController < ApplicationController
  before_filter :signed_in_user

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    #Listing 11.38 Responding to Ajax requests in the Relationships controller
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    #Listing 11.38 Responding to Ajax requests in the Relationships controller
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end