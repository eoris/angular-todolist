class TasksController < ApplicationController
  def create
    # @project = Project.find(task_params[:project_id])
    # @task = @project.tasks.new(task_params)
    @task = Task.new(task_params)
    if @task.save
       render json: @task, status: 200
    else
       render json: {:errors => @task.errors.full_messages}
    end
  end

  def update

  end

  def destroy

  end

  def task_params
    params.require(:task).permit(:title, :deadline, :position, :done, :project_id)
  end
end
