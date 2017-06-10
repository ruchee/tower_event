# == Schema Information
#
# Table name: comments
#
#  id            :uuid             not null, primary key
#  parent_id     :uuid
#  subject_model :string           not null
#  subject_id    :uuid             not null
#  user_id       :uuid             not null
#  content       :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_comments_on_parent_id  (parent_id)
#  index_comments_on_user_id    (user_id)
#

class Comment < ApplicationRecord
  belongs_to :user

  validates :content, presence: true

  after_create :new_create_event

  private

  def new_create_event
    item = self.subject_model.constantize.find(self.subject_id)
    project = item&.project
    project_id, team_id = project&.id, project&.team_id

    Event.create_new(uid: self.user_id, a: 'comment', amodel: 'Comment', aid: self.id, aname: item.name, pid: project_id, tid: team_id)
  end
end
