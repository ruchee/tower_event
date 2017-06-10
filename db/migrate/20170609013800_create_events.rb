class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events, id: :uuid do |t|
      t.uuid :user_id, null: false, comment: '参与人'
      t.string :action, null: false, comment: '动作'
      t.string :action_model, null: false, comment: '动作关联模型'
      t.uuid :action_id, null: false, comment: '动作关联ID'
      t.uuid :project_id, null: true, comment: '所属项目ID'
      t.uuid :team_id, null: false, comment: '所属团队ID'

      t.timestamps
    end

    add_index :events, :user_id
    add_index :events, :project_id
    add_index :events, :team_id
  end
end
