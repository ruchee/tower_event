class CreateTodos < ActiveRecord::Migration[5.1]
  def change
    create_table :todos, id: :uuid do |t|
      t.uuid :project_id, null: false, comment: '项目ID'
      t.uuid :user_id, null: false, comment: '任务创建者'
      t.string :name, null: false, comment: '任务名称'
      t.uuid :assignee, null: true, comment: '任务指派给的人'
      t.date :due_date, null: true, comment: '任务截止时间'
      t.integer :status, default: 0, comment: '任务状态'

      t.timestamps
    end

    add_index :todos, :project_id
    add_index :todos, :user_id
    add_index :todos, :status
  end
end
