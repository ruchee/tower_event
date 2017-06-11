require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:user) { User.first }

  describe 'nickname can not be blank' do
    it do
      u = User.create(email: 'xyz@xyz.com')
      expect(u.id).to eq(nil)
    end
  end

  describe 'email can not be blank' do
    it do
      u = User.create(nickname: 'xyz')
      expect(u.id).to eq(nil)
    end
  end

  describe 'email must be unique' do
    it do
      u = User.create(nickname: 'xyz', email: user.email)
      expect(u.id).to eq(nil)
    end
  end

end
