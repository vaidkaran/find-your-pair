require 'rails_helper'

describe User do
  it('should have the correct first name') do
    #user = FactoryGirl.build_stubbed(:user)
    user = FactoryGirl.create(:user)
    expect(user.fname).to eq('Karan')
  end
end
