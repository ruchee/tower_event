require 'rails_helper'

RSpec.describe Todo, type: :model do

  let(:user) { User.first }
  let(:project) { Project.first }

  describe 'name can not be blank' do
    it do
      todo = Todo.create(user_id: user.id, project_id: project.id)
      expect(todo.id).to eq(nil)
    end
  end

end
