class StaticPagesController < ApplicationController
  #Listing 10.34 Adding a micropost instance variable to the home action
  #Listing 10.41 Adding a feed instance variable to the home action
  def home
    if signed_in?
      @micropost    = current_user.microposts.build
      @feed_items   = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
end
