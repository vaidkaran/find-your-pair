class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def new
    @project = Project.new
  end

  def create
    begin
      @project = current_user.projects.create!(project_params)
      flash.now[:notice] = "Successfully created..."
      redirect_to(action: :new)
    rescue
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
