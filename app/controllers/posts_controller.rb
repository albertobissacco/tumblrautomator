class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client

  def reblog

  end

  def like

  end


  def destroy
  end

end
