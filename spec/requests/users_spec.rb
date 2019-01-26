require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "works! (now write some real specs)" do
      get users_path
      expect(response).to have_http_status(200)
    end
  end
  
  describe "POST /users" do
    it "works and created new user" do
    expect(User.count).to eq(0)
    expect do
      post users_path,
        params: { user: {
          name: "dave",
          email: "dave@example.com",
          password: "dave1",
          password_confirmation: "dave1"
        }}
    end.to change(User, :count).by(1)
    expect(response).to have_http_status(302)
    follow_redirect!
    expect(response).to have_http_status(200)
    expect(response.body).to include("User was successfully")
    puts User.all.inspect
    end
    
    it "dosen't work because of lack of name" do
      expect(User.count).to eq(0)
      post users_path,
        params: { user: {
          name: "",
          email: "dave@example.com",
          password: "dave1",
          password_confirmation: "dave1"
        }}
      expect(User.count).to eq(0)
      expect(response).to have_http_status(200)
      expect(response.body).to include CGI.escapeHTML("Name can't be blank")
    end
    
    it "dosen't work because of already registerd name" do
      expect(User.count).to eq(0)
      expect do
        post users_path,
          params: { user: {
            name: "dave",
            email: "dave@example.com",
            password: "dave1",
            password_confirmation: "dave1"
          }}
      end.to change(User, :count).by(1)

      expect(User.count).to eq(1)
      post users_path,
        params: { user: {
          name: "dave",
          email: "dave@example.com",
          password: "dave1",
          password_confirmation: "dave1"
        }}
      expect(User.count).to eq(1)
      expect(response).to have_http_status(200)
      expect(response.body).to include CGI.escapeHTML("Name has already been taken")
    end
    
    it "dosen't work because of lack of email" do
      expect(User.count).to eq(0)
      post users_path,
        params: { user: {
          name: "dave",
          email: "",
          password: "dave1",
          password_confirmation: "dave1"
        }}
      expect(User.count).to eq(0)
      expect(response).to have_http_status(200)
      expect(response.body).to include CGI.escapeHTML("Email can't be blank")
    end
    
    it "dosen't work because of invalid email address" do
      expect(User.count).to eq(0)
      post users_path,
        params: { user: {
          name: "dave",
          email: "dave",
          password: "dave1",
          password_confirmation: "dave1"
        }}
      expect(User.count).to eq(0)
      expect(response).to have_http_status(200)
      expect(response.body).to include CGI.escapeHTML("Email is invalid")

      post users_path,
        params: { user: {
          name: "dave",
          email: " dave@example.com",
          password: "dave1",
          password_confirmation: "dave1"
        }}
      expect(User.count).to eq(0)
      expect(response).to have_http_status(200)
      expect(response.body).to include CGI.escapeHTML("Email is invalid")

    end

  end
end
