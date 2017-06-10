class CreateUserTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :user_teams, id: :uuid do |t|
      t.uuid :user_id, null: false, comment: '用户ID'
      t.uuid :team_id, null: false, comment: '团队ID'

      t.timestamps
    end

    add_index :user_teams, [:user_id, :team_id], unique: true
    add_index :user_teams, :user_id
    add_index :user_teams, :team_id
  end
end
