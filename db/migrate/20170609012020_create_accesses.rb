class CreateAccesses < ActiveRecord::Migration[5.1]
  def change
    create_table :accesses, id: :uuid do |t|
      t.uuid :user_id, null: false, comment: '用户ID'
      t.uuid :team_id, null: false, comment: '团队ID'
      t.integer :role, default: 0, comment: '权限角色'
      t.uuid :access_projects, array: true, default: [], comment: '参与的项目'
      t.uuid :access_calendars, array: true, default: [], comment: '可访问的日历'

      t.timestamps
    end

    add_index :accesses, [:user_id, :team_id], unique: true
    add_index :accesses, :user_id
    add_index :accesses, :team_id
    add_index :accesses, :role
  end
end
