require 'rails_helper'

RSpec.describe UserTeam, type: :model do

  let(:user) { User.first }
  let(:team) { Team.first }

  describe 'item should unique' do
    it do
      expect {
        UserTeam.create(user_id: user.id, team_id: team.id)
      }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end

end
