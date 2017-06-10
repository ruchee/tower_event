# == Schema Information
#
# Table name: users
#
#  id         :uuid             not null, primary key
#  email      :string           not null
#  nickname   :string           not null
#  avatar     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  has_and_belongs_to_many :teams, through: :user_teams
  has_many :accesses
  has_many :todos
  has_many :comments
  has_many :events

  validates :email, presence: true, uniqueness: true
  validates :nickname, presence: true
end
