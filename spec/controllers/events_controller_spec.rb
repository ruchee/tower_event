require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  render_views

  describe ':index' do
    it 'should get the last comment' do
      get :index
      expect(response).to be_success
      expect(response.body).to include('第30条评论的回复')
    end
  end

end
