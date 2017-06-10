# == Schema Information
#
# Table name: teams
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_teams_on_user_id  (user_id)
#

class Team < ApplicationRecord
  has_and_belongs_to_many :users, through: :user_teams
  has_many :accesses
  has_many :projects
  has_many :events

  validates :name, presence: true

  after_create :init_info
  after_create :new_create_event

  # 团队添加成员
  def add_member(user_id, role: 'member')
    UserTeam.find_or_create_by(team_id: self.id, user_id: user_id)
    Access.find_or_create_by(team_id: self.id, user_id: user_id)&.update(role: Access.roles[role])
  end

  private

  # 团队创建时初始化管理员权限等信息
  def init_info
    add_member(self.user_id, role: 'administrator')
  end

  def new_create_event
    Event.create_new(uid: self.user_id, a: 'create', amodel: 'Team', aid: self.id, pid: nil, tid: self.id)
  end
end
