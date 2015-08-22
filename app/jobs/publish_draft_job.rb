class PublishDraftJob < ActiveJob::Base
  queue_as :publish

  def perform(blog_name, quantity, schedule, countdown, user)
    set_client(user)

    until count >= quantity.to_i
      drafts = @client.draft(params[:blog_name])["posts"]
      return flash[:notice] = "drafts not found!" if drafts.empty?
      drafts.shuffle! if ENV["SORT"] == "randomly"
      post_id = drafts.first["id"]
      @client.edit(params[:blog_name], :id => post_id, :state => "published" )
    end
  end

  def set_client(client)
    Tumblr.configure do |config|
        config.consumer_key = Rails.application.secrets.omniauth_provider_key
        config.consumer_secret = Rails.application.secrets.omniauth_provider_secret
        config.oauth_token = client.token
        config.oauth_token_secret = client.secret
      end
    @client = Tumblr::Client.new
  end

end
