namespace :archivating do
  task :archive => :environment do
    Post.where(state: ['published', 'declined']).each(&:archive_post)
  end
end
