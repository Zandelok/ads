# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  comment     :string
#  images      :json
#  state       :string
#  text        :string           not null
#  title       :string           not null
#  category_id :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_posts_on_category_id  (category_id)
#  index_posts_on_user_id      (user_id)
#
class Post < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :category

  validates_presence_of :title, :text
  mount_uploaders :images, ImageUploader

  aasm column: :state do
    state :draft, initial: true
    state :submitted, :approved, :declined, :published, :archived

    event :submit do
      transitions from: :draft, to: :submitted
    end

    event :undo do
      transitions from: :submitted, to: :draft
    end

    event :approve do
      transitions from: :submitted, to: :approved
    end

    event :decline do
      transitions from: :submitted, to: :declined
    end

    event :change do
      transitions from: %i[declined approved], to: :submitted
    end

    event :publish do
      transitions from: :approved, to: :published
    end

    event :archive do
      transitions from: %i[declined published], to: :archived
    end
  end

  def publish_post
    self.publish!
  end

  def archive_post
    self.archive!
  end
end
