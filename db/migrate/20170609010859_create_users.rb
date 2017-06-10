class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :users, id: :uuid do |t|
      t.string :email, null: false, comment: '邮箱'
      t.string :nickname, null: false, comment: '昵称'
      t.string :avatar, comment: '头像'

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
