FactoryBot.define do
  factory :user do
    email {"test@user.com"}
    password {"qwertyuiop"}
    password_confirmation {"qwertyuiop"}
  end
end
