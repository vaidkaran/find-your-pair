FactoryGirl.define do
  factory :technology do
    name {['ruby', 'nodejs', 'java', 'selenium', 'rails'].sample}
  end
end
