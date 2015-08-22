class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client

  def following
    @following = @client.following()
  end

  def likes
    @likes = @client.likes()
  end
end
