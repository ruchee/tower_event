require 'rails_helper'

RSpec.describe Team, type: :model do

  let(:user) { User.first }

  describe 'name can not be blank' do
    it do
      team = Team.create(user_id: user.id)
      expect(team.id).to eq(nil)
    end
  end

end
