# == Schema Information
#
# Table name: user_teams
#
#  id         :uuid             not null, primary key
#  user_id    :uuid             not null
#  team_id    :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_teams_on_team_id              (team_id)
#  index_user_teams_on_user_id              (user_id)
#  index_user_teams_on_user_id_and_team_id  (user_id,team_id) UNIQUE
#

class UserTeam < ApplicationRecord
  belongs_to :user
  belongs_to :team
end
