require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    let(:event) { FactoryBot.build(:event) }
    let(:event_without_time) { FactoryBot.build(:event, takes_place_at: nil) }

    it 'validates presence of takes_place_at' do
      expect(event).to be_valid
      expect(event_without_time).not_to be_valid
    end
  end

  context 'scopes' do
    describe 'future events' do
      let!(:future_event) {FactoryBot.create(:event, takes_place_at: 100.years.from_now )}
      let!(:past_event) {FactoryBot.create(:event, takes_place_at: 100.years.ago )}

      it "has future events" do
        expect(Event).to respond_to :upcoming
      end

      it "shows only future events" do
        future_events = Event.upcoming
        expect(future_events.size).to eq 1
        expect(future_events).to include(future_event)
        expect(future_events).not_to include(past_event)
      end
    end

    describe 'past events' do
      let!(:future_event) {FactoryBot.create(:event, takes_place_at: 100.years.from_now )}
      let!(:past_event) {FactoryBot.create(:event, takes_place_at: 100.years.ago )}

      it "has past events" do
        expect(Event).to respond_to :past
      end

      it "shows only past events" do
        past_events = Event.past
        expect(past_events.size).to eq 1
        expect(past_events).not_to include(future_event)
        expect(past_events).to include(past_event)
      end
    end
  end

  context 'associations' do
    describe 'with users' do
      let(:event){FactoryBot.create(:event)}

      it "has many users" do
        expect(event.users.size).to eq 0
        event.users << FactoryBot.create(:user)
        event.users << FactoryBot.create(:user)
        event.users << FactoryBot.create(:user)

        expect(event.users.size).to eq 3 
      end

      it "has only unique users" do
        user1 = FactoryBot.create(:user)

        expect(event.users.size).to eq 0

        event.users << user1
        expect {
          event.users << user1
        }.to raise_error ActiveRecord::RecordNotUnique

        expect(event.users).to include(user1)
        expect(event.users.size).to be 1
      end
    end
  end
end
