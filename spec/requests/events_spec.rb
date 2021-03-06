require 'rails_helper'
require 'request_helper'

RSpec.describe "/events", type: :request do
  
  # Event. As you add validations to Event, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {name: "Strammtisch", takes_place_at: Time.zone.now }
  }

  let(:invalid_attributes) {
    {name: "Strammtisch", takes_place_at: nil } # takes_place_at is required
  }

  context "with logged_in user" do
    
    let(:user) {FactoryBot.create(:user) }
    before(:each) do
      login(user)
    end

    after(:each) do
      logout
    end

    describe "GET /index" do
      it "renders a successful response" do
        Event.create! valid_attributes
        get events_url
        expect(response).to be_successful
      end
    end

    describe "GET /show" do
      it "renders a successful response" do
        event = Event.create! valid_attributes
        get event_url(event)
        expect(response).to be_successful
      end
    end

    describe "GET /new" do
      it "renders a successful response" do
        get new_event_url
        expect(response).to be_successful
      end
    end

    describe "GET /edit" do
      it "render a successful response" do
        event = Event.create! valid_attributes
        get edit_event_url(event)
        expect(response).to be_successful
      end
    end

    describe "POST /create" do
      context "with valid parameters" do
        it "creates a new Event" do
          expect {
            post events_url, params: { event: valid_attributes }
          }.to change(Event, :count).by(1)
        end

        it "redirects to the created event" do
          post events_url, params: { event: valid_attributes }
          expect(response).to redirect_to(event_url(Event.last))
        end
      end

      context "with invalid parameters" do
        it "does not create a new Event" do
          expect {
            post events_url, params: { event: invalid_attributes }
          }.to change(Event, :count).by(0)
        end

        it "renders a successful response (i.e. to display the 'new' template)" do
          post events_url, params: { event: invalid_attributes }
          expect(response).to be_successful
        end
      end
    end

    describe "PATCH /update" do
      context "with valid parameters" do

        let(:new_date) { 10.days.from_now.beginning_of_hour }
        let(:new_attributes) {
          {name: "Strammiger Tisch", takes_place_at: new_date }
        }

        it "updates the requested event" do
          event = Event.create! valid_attributes
          patch event_url(event), params: { event: new_attributes }
          event.reload
          expect(event.takes_place_at).to eq new_date
          expect(event.name).to eq "Strammiger Tisch"
        end

        it "redirects to the event" do
          event = Event.create! valid_attributes
          patch event_url(event), params: { event: new_attributes }
          event.reload
          expect(response).to redirect_to(event_url(event))
        end
      end

      context "with invalid parameters" do
        it "renders a successful response (i.e. to display the 'edit' template)" do
          event = Event.create! valid_attributes
          patch event_url(event), params: { event: invalid_attributes }
          expect(response).to be_successful
        end
      end
    end

    describe "DELETE /destroy" do
      it "destroys the requested event" do
        event = Event.create! valid_attributes
        expect {
          delete event_url(event)
        }.to raise_error ActionController::RoutingError
      end
    end
  end

  context "with guest user" do
    before(:each) do
      logout
    end

    describe "GET /index" do
      it "redirects to login page" do
        Event.create! valid_attributes
        get events_url
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe "GET /show" do
      it "redirects to login page" do
        event = Event.create! valid_attributes
        get event_url(event)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe "GET /edit" do
      it "redirects to login page" do
        event = Event.create! valid_attributes
        get edit_event_url(event)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "PATCH /update" do
      it "doesn't let you update" do
        event = Event.create! valid_attributes
        patch event_url(event), params: { event: valid_attributes }
        expect(response).to_not be_successful
      end
    end

    describe "POST /create" do
      it "doesn't let you create" do
        post events_url, params: { event: valid_attributes }
        expect(response).to_not be_successful
      end
    end

  end
end
