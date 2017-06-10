# == Schema Information
#
# Table name: projects
#
#  id         :uuid             not null, primary key
#  team_id    :uuid             not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_projects_on_team_id  (team_id)
#  index_projects_on_user_id  (user_id)
#

class Project < ApplicationRecord
  belongs_to :team
  has_many :todos
  has_many :comments

  validates :name, presence: true

  after_create :update_access
  after_create :new_create_event

  private

  def update_access
    access = Access.find_or_create_by(team_id: self.team_id, user_id: self.user_id)
    access.update(access_projects: access.access_projects << self.id)
  end

  def new_create_event
    Event.create_new(uid: self.user_id, a: 'create', amodel: 'Project', aid: self.id, pid: self.id, tid: self.team_id)
  end
end
