# == Schema Information
#
# Table name: categories
#
#  id   :bigint           not null, primary key
#  name :string           not null
#
class Category < ApplicationRecord
  validates_presence_of :name
end
