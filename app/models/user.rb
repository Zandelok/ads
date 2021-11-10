# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  description            :string
#  email                  :string           not null
#  encrypted_password     :string           not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer
#  surname                :string           not null
#  role_id                :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role_id               (role_id)
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
class User < ApplicationRecord
  belongs_to :role
  has_many :posts
  before_validation :assign_role

  validates_presence_of :name, :surname, :email, :role

  devise :database_authenticatable,
         :recoverable,
         :registerable,
         :rememberable,
         :trackable,
         :validatable

  def assign_admin_role
    role_to_asign = Role.find_by!(name: 'admin')
    self.role = role_to_asign
    save
  end

  def assign_user_role
    role_to_asign = Role.find_by!(name: 'user')
    self.role = role_to_asign
    save
  end

  private

  def assign_role
    return unless self.role.nil?
    self.role = Role.find_by!(name: 'user')
  end
end
