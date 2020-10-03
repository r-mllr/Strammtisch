require 'rails_helper'

RSpec.describe "events/edit", type: :view do
  before(:each) do
    @event = FactoryBot.create(:event)
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(@event), "post" do

      assert_select "input[name=?]", "event[name]"
    end
  end
end
