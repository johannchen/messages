class HomeController < ApplicationController
  skip_authorization_check

  def index
    @verse = current_user.verses.favorites.last if current_user 
  end
end
