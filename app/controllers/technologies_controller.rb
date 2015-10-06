class TechnologiesController < ApplicationController
  before_action :authenticate_user!

  def new
    @technology = Technology.new
  end

  def show
    @technology = Technology.find_by_id params[:id]
  end

  def create
    @technology = current_user.technologies.new(technology_params)
    if @technology.save
      flash[:notice] = "Successfully created..."
      redirect_to(action: :new)
    else
      render(action: :new)
    end
  end

  def destroy
    technology = current_user.technologies.find_by_id(params[:id])
    technology.destroy

    redirect_to action: :new
  end

  def technology_params
    params.require(:technology).permit(:name)
  end
end
