class WelcomeController < ApplicationController
  include FetchUsers

  before_action :authenticate_user!, except: [:index]
  def index
    if user_signed_in?
     redirect_to :lihp
    end
  end


  def lihp
  # Sets @tech_details A Hash with the key as the technology name and the value as array of Hash of user details
    options = {current_city: true}
    get_users_with_these_technologies(current_user.technologies.select(:name).distinct, options)

  # Sets @s_t_users: A Hash with key :student or :tutor and the value as the array of User objects
    get_s_t_users
  end


  def advance_search
    # Sets @users as an array of resulting user objects to be used in views
    get_adv_search_resulting_users(advance_search_conditions)
  end


  def same_technologies
  # Returns a Hash with the key as the technology name and the value as array of Hash of user details
    options = {current_city: false}
    get_users_with_these_technologies(current_user.technologies.select(:name).distinct, options)
  end


  def similar_projects
    current_user_project_platforms = []
    current_user.projects.select(:platform).distinct.each do |p|
      current_user_project_platforms << p.platform
    end

    record = []
    current_user_project_platforms.each do |p|
      sql = "select users.fname, projects.name, projects.user_id, projects.platform from users join projects on users.id=projects.user_id where projects.platform='#{p}' and users.id!=#{current_user.id};"
      record << ActiveRecord::Base.connection.execute(sql)
    end

    @similar_platform_projects=[]
    record.each do |r|
      r.each(as: :hash) do |result|
        @similar_platform_projects << result
      end
    end
  end


  def circle_requests
    @circles = current_user.circles.where("user_status=0")
  end


#######################
# Private methods below
#######################
  private
  def search_params
    params.permit(:technology, :city)
  end

  def advance_search_conditions
    get_filtered_adv_search_params(search_params)
  end

end
