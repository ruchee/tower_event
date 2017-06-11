require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:user) { User.first }
  let(:todo) { Todo.first }

  describe 'content can not be blank' do
    it do
      comment = Comment.create(user_id: user.id, subject_model: 'Todo', subject_id: todo.id)
      expect(comment.id).to eq(nil)
    end
  end

end
