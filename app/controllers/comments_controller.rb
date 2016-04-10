class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
       render json: @comment
    else
       render json: {:errors => @comment.errors.full_messages}
    end
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    render json: comment
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.delete
    render json: @comment
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :task_id)
  end
end
