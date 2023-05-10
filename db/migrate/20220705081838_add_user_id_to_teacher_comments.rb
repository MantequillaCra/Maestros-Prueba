class AddUserIdToTeacherComments < ActiveRecord::Migration[7.0]
  def change
    add_column :teacher_comments, :user_id, :integer
    add_index :teacher_comments, :user_id
  end
end
