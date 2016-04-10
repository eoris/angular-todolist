class TasksController < ApplicationController
  def create
    @task = Task.new(task_params)
    if @task.save
       render json: @task
    else
       render json: {:errors => @task.errors.full_messages}
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    render json: @task
  end

  def destroy
    @task = Task.find(params[:id])
    @task.delete
    render json: @task
  end

  private

  def task_params
    params.require(:task).permit(:title, :deadline, :position, :done, :project_id)
  end
end
