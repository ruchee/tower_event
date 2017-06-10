class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects, id: :uuid do |t|
      t.uuid :team_id, null: false, comment: '团队ID'
      t.uuid :user_id, null: false, comment: '项目创建者'
      t.string :name, null: false, comment: '项目名称'

      t.timestamps
    end

    add_index :projects, :team_id
    add_index :projects, :user_id
  end
end
