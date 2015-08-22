class DraftsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client

  def publish
   posts_enqueued = 0
    quantity = params[:quantity].to_i || 0

    until posts_enqueued >= quantity
      drafts = @client.draft(params[:blog_name])["posts"]
      return flash[:notice] = "drafts not found!" if drafts.empty?
      drafts.shuffle! if params[:sort] == "randomly"
      drafts.each do |post|
        post_id = post["id"]
        @client.edit(params[:blog_name], :id => post_id, :state => "published" )
        posts_enqueued += 1
        break if posts_enqueued >= quantity
      end
    end
    redirect_to root_path, :notice => "published #{posts_enqueued} posts#{", randomly!" if params[:sort]=="randomly"}"
  end

  def destroy

  end

end


