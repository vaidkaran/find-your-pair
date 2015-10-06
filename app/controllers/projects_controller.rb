class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      flash.now[:notice] = "Successfully created..."
      redirect_to(action: :new)
    else
      flash.now[:alert] = "An Error occured while saving your project"
      render 'welcome/lihp'
    end

  end

  def destroy
    project = current_user.projects.find_by_id(params[:id])
    project.destroy

    redirect_to action: :new
  end

  def project_params
    params.require(:project).permit(:name, :app_type, :platform)
  end
end
