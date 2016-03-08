require 'rails_helper'

describe WelcomeController, type: :controller do

  describe 'welcome#index' do
    it 'should return a status of 200 on #index' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'should render the index view for a logged out user' do
      get :index
      expect(response).to render_template('welcome/index')
    end

    it 'should redirect to lihp for a logged in user' do
      user = FactoryGirl.create(:user)
      sign_in user
      get :index
      expect(response).to redirect_to(lihp_url)
    end
  end


  describe 'welcome#lihp' do
    before :each do
      user = FactoryGirl.create(:user)
      sign_in user
    end

    it 'should not be able to enter duplicate technologies'

    it 'sets @s_t_users with correct values' do
      pending 'First work on the scenario "should not be able to enter duplicate technologies"'
      user = FactoryGirl.create(:user_with_technologies)
      sign_in user

      current_user_technologies = user.technologies
      tech_details = {}
      #current_user_technologies.each do |t|
      #  tech_details[t.to_sym] = {}
      #end

      users = []
      10.times {users.push(FactoryGirl.create(:user_with_technologies))}

      current_user_technologies.each do |current_user_t|
        users.each do |u|
          u.technologies.each do |other_user_t|
            if current_user_t.name == other_user_t.name
              tech_details[current_user_t.name.to_sym] = {fname: u.fname, id: u.id}
            end
          end
        end
      end

      get :lihp
      require 'pry'; binding.pry
      puts 'hi'
    end

  end
end
