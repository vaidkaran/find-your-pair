module AdvanceSearch
  extend ActiveSupport::Concern

  def getme_users(adv_search_conditions)
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

    # get the intersection of the search field inputs (in case user has filled more than one field)
    unless search_result_user_ids.empty?
      @users = User.find(get_intersection_result(search_result_user_ids))
    end
  end


#######################
# Private methods below
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
