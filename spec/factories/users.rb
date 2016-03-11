FactoryGirl.define do
  factory :user do
    sequence(:fname) {|n| "Karan#{n}"}
    sequence(:lname) {|n| "Vaid#{n}"}
    email {"#{fname}#{lname}@test.com"}
    password 'kkkkkkkk'
    profession 'Software Engineer'
    city 'Gurgaon'
    state 'Haryana'
    country 'India'
    tutor {[true, false].sample}
    student {[true, false].sample}
    team {[true, false].sample}

    factory :user_with_technologies do
      transient do
        technologies_count 5
        after :create do |user, evaluator|
          create_list(:technology, evaluator.technologies_count, user: user)
        end
      end
    end

  end
end

