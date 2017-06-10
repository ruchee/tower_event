class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams, id: :uuid do |t|
      t.uuid :user_id, null: false, comment: '团队创建者'
      t.string :name, null: false, comment: '团队名称'

      t.timestamps
    end

    add_index :teams, :user_id
  end
end
