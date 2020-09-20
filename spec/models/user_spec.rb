require 'rails_helper'

RSpec.describe User, type: :model do
  it 'can create user' do
    expect(FactoryBot.create(:user)).to be_a(User)
  end
end
