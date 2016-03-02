require 'rails_helper'

describe WelcomeController, type: :controller do
  it 'should return a status of 200 on #index' do
    get :index
    expect(response.status).to eq(200)
  end

  it 'should render the index view for a logged out user'
    #current_user = nil
    #get :index
    #expect(response).to render_template('welcome/index')

  it 'should render the lihp view for a logged in user' do
    #@request.env["devise.mapping"] = Devise.mappings[:user]
    #user = FactoryGirl.build_stubbed(:user)
    user = FactoryGirl.create(:user)
    sign_in user
    get :index

    expect(response).to redirect_to(lihp_url)
  end
end
