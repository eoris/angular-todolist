class CommentsController < ApplicationController
  load_resource :task
  load_and_authorize_resource :comment, through: :task, shallow: true

  def create
    if @comment.save
      render json: @comment
    else
      render json: {:errors => @comment.errors.full_messages}
    end
  end

  def destroy
    @comment.destroy
    render json: @comment
  end

  private

  def comment_params
    params.permit(:text, :task_id)
  end
end
