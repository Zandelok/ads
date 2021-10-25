# == Schema Information
#
# Table name: roles
#
#  id   :bigint           not null, primary key
#  role :string           not null
#
class Role < ApplicationRecord
  validates_presence_of :role, only: %i[create]
end
