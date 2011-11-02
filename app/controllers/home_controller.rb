class HomeController < ApplicationController
  skip_authorization_check

  def index
    @verse = current_user.verses.last if current_user 
  end
end
