require 'rails_helper'
require 'request_helper'

RSpec.describe "Admin::Applications", type: :request do

  context "access" do

    let(:user){ FactoryBot.create(:user) }
    let(:admin){ FactoryBot.create(:user, :admin) }

    it "lets you in if you're an admin" do
      login(admin)

      get '/admin/' 
      expect(response).to have_http_status(:success)
    end

    it "locks you out if you don't have admin privileges" do
      login(user)

      get '/admin/' 
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(root_path)
    end

    it "locks you out if you are not logged in" do
      # no login

      get '/admin/' 
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

end
