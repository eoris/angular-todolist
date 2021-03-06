class ProjectsController < ApplicationController
  load_and_authorize_resource through: :current_user

  def index
    render json: @projects, root: false
  end

  def create
    if @project.save
      render json: @project
    else
      render json: {:errors => @project.errors.full_messages}
    end
  end

  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: {:errors => @project.errors.full_messages}
    end
  end

  def destroy
    @project.destroy
    render json: @project
  end

  private

  def project_params
    params.permit(:title)
  end
end
