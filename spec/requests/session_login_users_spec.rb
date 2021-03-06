require 'rails_helper'

RSpec.describe "SessionLoginUsers", type: :request do
  describe "GET /session_login_users" do
    it "works! (now write some real specs)" do
      get login_path
      expect(response).to have_http_status(200)
    end
  end
  
  describe "POST /login" do
    let!(:user1){ create(:user) }
    it "works with name and password" do
      puts User.all.inspect
      post login_path,
        params: { session: {
          name: user1.name,
          password: user1.password
        }}
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response).to render_template "users/show"
      expect(response.body).to include CGI.escapeHTML("Login successfully")
    end
    
    it "doesn't work because of invalid name or password" do
      puts User.all.inspect
      post login_path,
        params: { session: {
          name: user1.name,
          password: "user11234"
        }}
      expect(response).to render_template "sessions/new"
      expect(response.body).to include CGI.escapeHTML("Invalid name or password")

      post login_path,
        params: { session: {
          name: user1.name,
          password: nil
        }}
      expect(response).to render_template "sessions/new"
      expect(response.body).to include CGI.escapeHTML("Invalid name or password")
    end
  end
  
  describe "DELETE/logout" do
    let!(:user1){ create(:user) }
    it "works" do
      puts User.all.inspect
      post login_path,
        params: { session: {
          name: user1.name,
          password: user1.password
        }}
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response).to render_template "users/show"
      expect(response.body).to include CGI.escapeHTML("Login successfully")
      
      delete logout_path
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response).to render_template "sessions/new"
      expect(response.body).to include CGI.escapeHTML("Logout successfully")
    end
    
    it "doesn't work because not login yet" do
      puts User.all.inspect
      delete logout_path
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response).to render_template "sessions/new"
      expect(response.body).to include CGI.escapeHTML("Please login")
    end
    
  end
  
end
