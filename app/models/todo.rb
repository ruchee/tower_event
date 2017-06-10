# == Schema Information
#
# Table name: todos
#
#  id         :uuid             not null, primary key
#  project_id :uuid             not null
#  user_id    :uuid             not null
#  name       :string           not null
#  assignee   :uuid
#  due_date   :date
#  status     :integer          default("todo")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_todos_on_project_id  (project_id)
#  index_todos_on_status      (status)
#  index_todos_on_user_id     (user_id)
#

class Todo < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :name, presence: true

  after_create :new_create_event

  enum status: { todo: 0, done: 1, deleted: 3 }  # 0:未完成 1:已完成 3:已删除

  # 查询结果默认不包含已删除的条目
  default_scope { where.not(status: Todo.statuses['deleted']) }

  private

  def new_create_event
    Event.create_new(uid: self.user_id, a: 'create', amodel: 'Todo', aid: self.id, aname: self.name, pid: self.project_id,
                     tid: Project.find(self.project_id)&.team_id)
  end
end
