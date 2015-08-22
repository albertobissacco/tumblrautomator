class Viewer::BlogController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client

  def index
    @blog = Viewer::BlogController.instance_methods(false)
    # @blog = Rails.application.routes.named_routes.helpers
  end

  def info
    @blog = @client.blog_info(params[:name])
  end

  def avatar
    @blog = @client.avatar(params[:name])
  end

  def followers
    @blog = @client.followers(params[:name])
  end

  def likes
    @blog = @client.blog_likes(params[:name])
  end

  def posts
    @blog = @client.posts(params[:name], :type => params[:type], :offset => params[:offset])
  end

  def queue
    @blog = @client.queue(params[:name])
  end

  def draft
    @blog = @client.draft(params[:name], :before_id => params[:offset])
  end

  def submissions
    @blog = @client.submissions(params[:name])
  end
end
