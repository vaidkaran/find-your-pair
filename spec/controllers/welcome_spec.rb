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

    it 'should have a valid user in current_user' do
      expect(controller.current_user.email).to eq 'vaidkaran89@gmail.com'
    end

    it 'sets @s_t_users with correct values'

  end
end
