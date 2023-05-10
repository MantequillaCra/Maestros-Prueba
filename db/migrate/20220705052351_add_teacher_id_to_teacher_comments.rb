class AddTeacherIdToTeacherComments < ActiveRecord::Migration[7.0]
  def change
    add_column :teacher_comments, :teacher_id, :integer
    add_index :teacher_comments, :teacher_id
  end
end
