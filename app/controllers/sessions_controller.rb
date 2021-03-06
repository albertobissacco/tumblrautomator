class SessionsController < ApplicationController

  def new
    redirect_to '/auth/tumblr'
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by(:uid => auth['uid']) || User.create_with_omniauth(auth)
    user.update_attribute :blogs, auth["info"]["blogs"].map { |blog| blog["name"] }
    reset_session
    session[:user_id] = user.id
    redirect_to root_url, :notice => 'Signed in!'
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
