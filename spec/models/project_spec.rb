require 'rails_helper'

RSpec.describe Project, type: :model do

  let(:user) { User.first }
  let(:team) { Team.first }

  describe 'name can not be blank' do
    it do
      project = Project.create(user_id: user.id, team_id: team.id)
      expect(project.id).to eq(nil)
    end
  end

end
