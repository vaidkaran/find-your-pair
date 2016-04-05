FactoryGirl.define do
  factory :technology do
    sequence(:name) { |n| "techname#{n}" }
  end
end
