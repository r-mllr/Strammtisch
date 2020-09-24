FactoryBot.define do
  factory :user do
    name { Faker::Movies::HarryPotter.character }
    email { Faker::Internet.unique.email }
    password {'password'}
    password_confirmation {'password'}
    confirmed_at {Time.zone.now}

    trait :admin do
      admin {true}
    end
  end
end
