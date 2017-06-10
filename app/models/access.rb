# == Schema Information
#
# Table name: accesses
#
#  id               :uuid             not null, primary key
#  user_id          :uuid             not null
#  team_id          :uuid             not null
#  role             :integer          default("default")
#  access_projects  :uuid             default([]), is an Array
#  access_calendars :uuid             default([]), is an Array
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_accesses_on_role                 (role)
#  index_accesses_on_team_id              (team_id)
#  index_accesses_on_user_id              (user_id)
#  index_accesses_on_user_id_and_team_id  (user_id,team_id) UNIQUE
#

class Access < ApplicationRecord
  belongs_to :user
  belongs_to :team

  enum role: { default: 0, administrator: 1, member: 2, visitor: 3 }  # 0:默认 1:管理员 2:成员 3:访问者
end
