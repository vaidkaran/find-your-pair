require 'rails_helper'

describe WelcomeController, type: :controller do
  it 'should return a status of 200 on #index' do
    get :index
    expect(response.status).to eq(200)
  end
end
