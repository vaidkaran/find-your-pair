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

    it 'should not be able to enter duplicate technologies' do
      user = FactoryGirl.create(:user)
      user.technologies.new(name: 'ruby')
      expect(user.save).to be true
      user.technologies.new(name: 'ruby')
      expect(user.save).to be false
    end

    it 'sets @s_t_users with correct values' do
      user = FactoryGirl.create(:user)
      sign_in user

      current_user_technologies = user.technologies
      tech_details = {}
      #current_user_technologies.each do |t|
      #  tech_details[t.to_sym] = {}
      #end

      # create some more users
      other_user1 = FactoryGirl.create(:user, student: true, tutor: false)
      other_user2 = FactoryGirl.create(:user, student: false, tutor: true)
      other_user3 = FactoryGirl.create(:user, student: true, tutor: true)
      other_user4 = FactoryGirl.create(:user, student: false, tutor: false)

      # set a common technology for current_user and other users
      other_users.each do |u|
        u.technologies.new(name: 'ruby')
      end

      current_user_technologies.each do |current_user_t|
        other_users.each do |u|
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
