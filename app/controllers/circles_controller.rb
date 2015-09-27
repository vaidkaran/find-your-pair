class CirclesController < ApplicationController
  def index
    @user_circles = current_user.circles
  end

  def show
    @circle = Circle.find_by_id params[:id]
  end

  def circle_request
    circle_request_params

  end

  def new
    @circle = Circle.new
  end

  def create
    @circle = Circle.new(circle_params)
    if @circle.save
      #Circle creater is the admin with user_status 1 (confirmed member)
      fc = current_user.friend_circles.new({circle_id: @circle.id, admin: 1, user_status: 1})
      if fc.save
        flash[:notice] = "Circle successfully created"
        redirect_to(action: :new)
      else
        flash[:alert] = "An Error occured while saving your Circle. Please try again."
        render 'welcome/lihp'
      end
    else
      flash[:alert] = "An Error occured while saving your Circle. Please try again."
      render 'welcome/lihp'
    end
  end

  def circle_params
    params.require(:circle).permit(:name, :description, :motive)
  end

  def circle_request_params
    # any user requested is not an admin and the user status is pending by default
    params[:admin] = 0
    params[:user_status] = 0
    params.permit(:circle_id, :admin, :user_status)
  end

end
