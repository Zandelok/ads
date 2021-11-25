namespace :archivating do
  task archive: :environment do
    Post.where(state: %w[published declined]).each(&:archive_post)
  end
end
