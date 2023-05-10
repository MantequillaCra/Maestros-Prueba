class TeacherCommentsController < ApplicationController
  def create
    @teacher = Teacher.find(params[:teacher_id])
    @teacher_comment = @teacher.teacher_comments.create(comment_params)
    redirect_to teacher_path(@teacher)
  end

 private
  def comment_params
    params.require(:teacher_comment).permit(:title, :body, :user_id)
  end
end
