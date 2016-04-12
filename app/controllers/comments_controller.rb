class CommentsController < ApplicationController
  load_and_authorize_resource :task
  load_and_authorize_resource :comment, through: :task, shallow: true

  def create
    if @comment.save
      render json: @comment
    else
      render json: {:errors => @comment.errors.full_messages}
    end
  end

  def destroy
    @comment.delete
    render json: @comment
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :task_id)
  end
end
