require 'rails_helper'

RSpec.describe "SessionLoginUsers", type: :request do
  describe "GET /session_login_users" do
    it "works! (now write some real specs)" do
      get login_path
      expect(response).to have_http_status(200)
    end
  end
  
  describe "POST /login" do
    it "works with name and password" do
      post login_path,
        params: { session: {
          name: "dave",
          password: "dave1234"
        }}
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(current_path).to eq user_path
      expect(response.body).to include CGI.escapeHTML("Login successfully")
            
    end
  end
end
