class SessionsController < ApplicationController
  skip_authorization_check

  def create
    auth = request.env["omniauth.auth"]

    if session[:user_id]
      User.find(session[:user_id]).add_provider(auth)
      render :text => "You can now login using #{auth["provider"].capitalize} too!"
    else 
      # log in
      login = Authentication.find_or_create(auth)

      # create the session
      session[:user_id] = login.user.id
      redirect_to root_url, :notice => "Signed in!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
  end
end
