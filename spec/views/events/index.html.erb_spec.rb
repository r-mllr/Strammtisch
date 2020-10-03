require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    assign(:events, [
      FactoryBot.create(:event, name: "Name"),
      FactoryBot.create(:event, name: "Name"),
      FactoryBot.create(:event, name: "Name")
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 3
  end
end
