class AddColumnsToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :content, :string, null: true, comment: '事件描述'
    add_column :events, :action_name, :string, null: false, comment: '动作关联名称'
  end
end
