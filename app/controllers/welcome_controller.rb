class WelcomeController < ApplicationController
  def index
  end

  def lihp
  end

  def similar_projects
    current_user_project_platforms = []
    current_user.projects.select(:platform).distinct.each do |p|
      current_user_project_platforms << p.platform
    end

    record = []
    current_user_project_platforms.each do |p|
      sql = "select users.fname, projects.name, projects.platform from users join projects on users.id=projects.user_id where projects.platform='#{p}' and users.id!=#{current_user.id};"
      record << ActiveRecord::Base.connection.execute(sql)
    end

    @similar_platform_projects=[]
    record.each do |r|
      r.each(as: :hash) do |result|
        @similar_platform_projects << result
      end
    end
  end
end
