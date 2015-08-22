class BlogController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client

  def show
    @blog = @client.blog_info(params[:blog_name])
  end

  def posts
    @posts = @client.posts(params[:blog_name], :type => params[:type], :offset => params[:offset])
  end

  def drafts
    @posts = @client.draft(params[:blog_name])
  end

  def queue
    @posts = @client.queue(params[:blog_name])
  end

  def followers
    @followers = @client.followers(params[:blog_name])
  end

  def likes
    @likes = @client.blog_likes(params[:blog_name])
  end
end
