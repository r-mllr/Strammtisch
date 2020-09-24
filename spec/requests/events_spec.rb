require 'rails_helper'

RSpec.describe "Events", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/events/"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do

    let(:event) { FactoryBot.create(:event) }

    it "returns http success" do
      get "/events/#{event.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do

    let(:event){ FactoryBot.create(:event) }
    
    it "returns http success" do
      patch "/events/#{event.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    
    let(:event){ FactoryBot.build(:event)}

    it "returns http success" do
      post "/events/", params: event.to_param
      expect(response).to have_http_status(:success)
    end
  end

end
