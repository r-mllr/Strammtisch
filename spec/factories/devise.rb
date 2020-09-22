FactoryBot.define do
  factory :user do
    email { 'test@user.com'}
    password {'password'}
    password_confirmation {'password'}
    confirmed_at {Time.zone.now}

    trait :admin do
      admin {true}
    end
  end
end
