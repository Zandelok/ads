# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  description :string
#  email       :string           not null
#  name        :string           not null
#  surname     :string           not null
#
class User < ApplicationRecord
  has_many :posts

  validates_presence_of :name, :surname, :email
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
