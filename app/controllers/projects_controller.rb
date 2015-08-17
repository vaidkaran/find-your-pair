class ProjectsController < ApplicationController
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
  end

  def project_params
    params.require(:project).permit(:name, :app_type, :platform)
  end
end
