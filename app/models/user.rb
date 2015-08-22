class User < ActiveRecord::Base
  serialize :blogs, Array

  def self.create_with_omniauth(auth)
    blogs = auth["info"]["blogs"].map { |blog| blog["name"] }
    create! do |user|
      user.name = auth['info']['name']
      user.uid = auth['uid']
      user.token = auth["credentials"]["token"]
      user.secret = auth["credentials"]["secret"]
      user.blogs = blogs
    end
  end

end
