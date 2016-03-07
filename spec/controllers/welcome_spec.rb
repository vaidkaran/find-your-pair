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
      users = 10.times {FactoryGirl.create(:user_with_technologies)}
      user = FactoryGirl.create(:user_with_technologies)
      sign_in user
      get :lihp
      p @s_t_users
      require 'pry'; binding.pry
      puts 'hi'
    end

  end
end
