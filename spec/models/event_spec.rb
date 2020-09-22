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
end
