class WelcomeController < ApplicationController
  include AdvanceSearch

  before_action :authenticate_user!, except: [:index]
  def index
    if user_signed_in?
      redirect_to :lihp
    end
  end


  def lihp
  end


  def advance_search
    getme_users(advance_search_conditions)
  end


  def same_technologies
    current_user_technologies = []
    current_user.technologies.select(:name).distinct.each do |t|
      current_user_technologies << t.name
    end

#################################################
# NEED TO CLEAN THIS UP. USE A SIMPLER LOGIC
#################################################
    record = {}
    current_user_technologies.each do |t|
      sql = "SELECT u.fname, u.id FROM users u INNER JOIN technologies t ON u.id = t.user_id WHERE t.name='#{t}' and t.user_id!=#{current_user.id};"
      record[t.to_sym] = ActiveRecord::Base.connection.execute(sql)
    end

    @tech_details = {}
    record.each do |tech_name, user_details|
      @tech_details[tech_name.to_sym] = []
      user_details.each(as: :hash) do |result|
        @tech_details[tech_name.to_sym] << result
      end
    end
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
