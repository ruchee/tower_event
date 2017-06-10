# == Schema Information
#
# Table name: events
#
#  id           :uuid             not null, primary key
#  user_id      :uuid             not null
#  action       :string           not null
#  action_model :string           not null
#  action_id    :uuid             not null
#  project_id   :uuid
#  team_id      :uuid             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_events_on_project_id  (project_id)
#  index_events_on_team_id     (team_id)
#  index_events_on_user_id     (user_id)
#

class Event < ApplicationRecord
  belongs_to :team
  belongs_to :user

  class <<self
    def create_new(info)
      Event.create(
        user_id: info[:uid],
        action: info[:a],
        action_model: info[:amodel],
        action_id: info[:aid],
        project_id: info[:pid],
        team_id: info[:tid]
      )
    end
  end

end
