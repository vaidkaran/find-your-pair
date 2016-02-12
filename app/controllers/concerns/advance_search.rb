module AdvanceSearch
  extend ActiveSupport::Concern

  ############################################################
  # Params: Hash of advance search conditions
  #
  # Sets: @users = An array of the resulting user objects
  #
  # Returns: @users
  ############################################################
  def get_adv_search_resulting_users(adv_search_conditions)
    search_result_user_ids = []
    # search only if user performs a non empty search
    if advance_search_conditions[:technology]
      tech_user_ids = Technology.search(advance_search_conditions[:technology]).map { |t| t.user_id.to_i }
      search_result_user_ids << tech_user_ids
    end
    if advance_search_conditions[:city]
      city_user_ids = User.search(advance_search_conditions[:city]).map { |u| u.id.to_i }
      search_result_user_ids << city_user_ids
    end

    #returns an array of the resulting User objects
    unless search_result_user_ids.empty?
    # get the intersection of the search field inputs (in case user has filled more than one field)
      @users = User.find(get_intersection_result(search_result_user_ids))
    end
  end

  ############################################################
  # Params: Array of Technology objects
  #
  # Sets: @tech_details = A Hash with the key as the technology name and the value as array of Hash of user details
  #
  # Returns: @tech_details
  ############################################################
  def get_users_with_these_technologies(user_technologies, options={})

    if(options[:current_city]==true)
      with_current_city = "and u.city='#{current_user.city}'"
    else
      with_current_city = ""
    end

    record = {}
    user_technologies.each do |t|
      sql = "SELECT u.fname, u.id FROM users u INNER JOIN technologies t ON u.id = t.user_id WHERE t.name='#{t.name}' and t.user_id!=#{current_user.id} #{with_current_city};"
      record[t.name.to_sym] = ActiveRecord::Base.connection.execute(sql)
    end

    @tech_details = {}
    record.each do |tech_name, user_details|
      @tech_details[tech_name.to_sym] = []
      user_details.each(as: :hash) do |result|
        @tech_details[tech_name.to_sym] << result
      end
    end
  end

  def get_filtered_adv_search_params(search_params)
    options = {}
    unless(search_params[:city].nil?)
      options[:city] = search_params[:city] if(!search_params[:city].strip.empty?)
    end
    unless(search_params[:technology].nil?)
      options[:technology] = search_params[:technology] if(!search_params[:technology].strip.empty?)
    end
    return options
  end


#######################
# PRIVATE METHODS BELOW
#######################
  private

  # Takes an array of array. Returns an array from the intersection of each element of the input array
  def get_intersection_result(search_result_user_ids)
    ref = search_result_user_ids[0]
    search_result_user_ids.each do |array|
      ref = ref & array
    end
    return ref
  end
  # Takes an array of array. Returns an array from the intersection of each element of the input array
  def get_intersection_result(search_result_user_ids)
    ref = search_result_user_ids[0]
    search_result_user_ids.each do |array|
      ref = ref & array
    end
    return ref
  end
end
