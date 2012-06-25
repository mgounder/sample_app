#Listing 10.28 Created microposts_controller.rb and populate with the below
#to add authentication to the Microposts controller actions
#Mainly, adding before_filter for signed_in_user on the create and destroy actions
class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy] #:destroy added with Listing 10.49
  before_filter :correct_user,   only: :destroy #:destroy added with Listing 10.49

  #Listing 10.30 The Microposts controller create action
  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  #Listing 10.49 The Microposts controller destory action
  def destroy
    @micropost.destroy
    redirect_to root_path
  end
  
  private
  
    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @micropost.nil?
    end
end