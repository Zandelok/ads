# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  image_url   :string
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
  belongs_to :user
  belongs_to :category

  validates_presence_of :title, :text
end
