class TechnologiesController < ApplicationController
  def new
    @technology = Technology.new
  end

  def create
    begin
      @technology = current_user.technologies.create!(technology_params)
      flash.now[:notice] = "Successfully created..."
      redirect_to(action: :new)
    rescue
      flash.now[:alert] = "An Error occured while saving your technologies"
      render 'welcome/lihp'
    end
  end

  def destroy
  end

  def technology_params
    params.require(:technology).permit(:name)
  end
end
