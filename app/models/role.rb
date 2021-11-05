# == Schema Information
#
# Table name: roles
#
#  id   :bigint           not null, primary key
#  name :string           not null
#
class Role < ApplicationRecord
  validates_presence_of :name, only: %i[create]
end
