class ProjectsController < ApplicationController
  def index
    @projects = Project.all
    render json: @projects, include: 'tasks'
  end

  def create
    @project = Project.new(project_params)
    if @project.save
       render json: @project, status: 200
    else
       render json: {:errors => @project.errors.full_messages}
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
       render json: @project, status: 200
    else
       render json: {:errors => @project.errors.full_messages}
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
       render json: @project, status: 200
    else
       render json: {:errors => @project.errors.full_messages}
    end
  end

  private

  def project_params
    params.require(:project).permit(:title)
  end
end
