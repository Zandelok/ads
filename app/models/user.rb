# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  description :string
#  email       :string
#  name        :string
#  surname     :string
#
class User < ApplicationRecord
  validates_presence_of :name, :surname
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
