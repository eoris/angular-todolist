class TasksController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :task, through: :project, shallow: true

  def create
    if @task.save
      render json: @task
    else
      render json: {:errors => @task.errors.full_messages}
    end
  end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: {:errors => @task.errors.full_messages}
    end
  end

  def destroy
    @task.destroy
    render json: @task
  end

  private

  def task_params
    params.permit(:title, :deadline, :position, :done, :project_id)
  end
end
