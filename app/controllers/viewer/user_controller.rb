class Viewer::UserController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client

  def index
    @info = Viewer::UserController.instance_methods(false)

  end

  def info
    @user = @client.info
  end

  def dashboard
    @user = @client.dashboard()
  end

  def likes
    @user = @client.likes()
  end

  def following
    @user = @client.following()
  end

  def follow
    @user = @client.follow()
  end

  def unfollow
    @user = @client.unfollow()
  end

  def like
    @user = @client.like()
  end

  def unlike
    @user = @client.info()
  end
end
