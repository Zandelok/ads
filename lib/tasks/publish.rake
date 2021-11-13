namespace :publishing do
  task :publish => :environment do
    Post.where(state: 'approved').each(&:publish_post)
  end
end
