require 'rails_helper'

RSpec.describe User, type: :model do
  it 'can create user' do
    expect(FactoryBot.create(:user)).to be_a(User)
  end

  context 'associations' do
    describe 'events' do
      let(:user){FactoryBot.create(:user)}

      it "can create events" do
        expect(user.events.size).to be 0
        user.events.create(FactoryBot.build(:event).to_param)
        expect(user.events.size).to be 1
        user.events.create(FactoryBot.build(:event).to_param)
        expect(user.events.size).to be 2
      end
    end
  end
end
