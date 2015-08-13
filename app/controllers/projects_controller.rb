class ProjectsController < ApplicationController
  def new
    @user = User.new
    require 'pry'; binding.pry
    @project = Project.new
  end

  def create
    @user = User.new(params[:user_id])
    #@project = @user.projects.build(project_params)
    begin
      require 'pry'; binding.pry
      @project = @user.projects.create!(project_params)
      flash.now[:notice] = "Successfully created..."
      redirect_to action: :new
    rescue
      flash.now[:alert] = "An Error occured while saving your project"
      render 'welcome/lihp'
    end
    #@project = Project.new(project_params)
    #if @project.save
    #  flash.now[:notice] = "Successfully created..."
    #  redirect_to action: :new
    #else
    #  flash.now[:alert] = "An Error occured while saving your project"
    #  render 'welcome/lihp'
    #end
  end

  def destroy
  end

  def project_params
    params.require(:project).permit(:name, :app_type, :platform)
  end
end
