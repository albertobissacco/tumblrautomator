namespace :drafts do

  desc "TODO"
  task :publish, [:blog_name] => :environment do |t, args|
    user = User.admin.first
    blog_name = args[:blog_name]
    quantity = ENV["N"]
    schedule = ENV["EVERY"] #array => [2, minutes]

    PublishDraftJob.perform_later(blog_name, quantity, schedule, user)
  end

end
