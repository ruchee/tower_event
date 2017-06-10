class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments, id: :uuid do |t|
      t.uuid :parent_id, null: true, comment: '父评论ID'
      t.string :subject_model, null: false, comment: '回复主体模型'
      t.uuid :subject_id, null: false, comment: '回复主体ID'
      t.uuid :user_id, null: false, comment: '用户ID'
      t.text :content, null: false, comment: '评论内容'

      t.timestamps
    end

    add_index :comments, :parent_id
    add_index :comments, :user_id
  end
end
