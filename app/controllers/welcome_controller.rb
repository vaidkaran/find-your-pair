class WelcomeController < ApplicationController
  def index
  end

  def lihp
  end

  def similar_projects
    user_project_platforms = []
    current_user.projects.each do |p|
      user_project_platforms << p.platform.to_s
    end

    sql = "select users.fname, projects.name, projects.platform from users join projects on users.id=projects.user_id where projects.platform='java';"
    ActiveRecord::Base.connection.execute sql
  end
end
