require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /users" do
    it "works and created new user" do
    expect(User.count).to eq(0)
    expect do
      post users_path,
        params: { user: {
          name: "dave",
          email: "dave@example.com",
          password: "dave1234",
          password_confirmation: "dave1234"
        }}
    end.to change(User, :count).by(1)
    expect(response).to have_http_status(302)
    follow_redirect!
    expect(response).to render_template "users/show"
    expect(response.body).to include("User was successfully")
    puts User.all.inspect
    end
    
    it "dosen't work because of lack of name" do
      expect(User.count).to eq(0)
      post users_path,
        params: { user: {
          name: "",
          email: "dave@example.com",
          password: "dave1234",
          password_confirmation: "dave1234"
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
            password: "dave1234",
            password_confirmation: "dave1234"
          }}
      end.to change(User, :count).by(1)

      expect(User.count).to eq(1)
      post users_path,
        params: { user: {
          name: "dave",
          email: "dave@example.com",
          password: "dave1234",
          password_confirmation: "dave1234"
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
          password: "dave1234",
          password_confirmation: "dave1234"
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
          password: "dave1234",
          password_confirmation: "dave1234"
        }}
      expect(User.count).to eq(0)
      expect(response).to have_http_status(200)
      expect(response.body).to include CGI.escapeHTML("Email is invalid")

      post users_path,
        params: { user: {
          name: "dave",
          email: " dave@example.com",
          password: "dave1234",
          password_confirmation: "dave1234"
        }}
      expect(User.count).to eq(0)
      expect(response).to have_http_status(200)
      expect(response.body).to include CGI.escapeHTML("Email is invalid")
    end

    it "dosen't work because of lack of password" do
      expect(User.count).to eq(0)
      post users_path,
        params: { user: {
          name: "dave",
          email: "dave@example.com",
          password: "",
          password_confirmation: ""
        }}
      expect(User.count).to eq(0)
      expect(response).to have_http_status(200)
      expect(response.body).to include CGI.escapeHTML("Password can't be blank")
      expect(response.body).to include CGI.escapeHTML("Password confirmation can't be blank")

      expect(User.count).to eq(0)
      post users_path,
        params: { user: {
          name: "dave",
          email: "dave@example.com",
          password: "      ",
          password_confirmation: " "
        }}
      expect(User.count).to eq(0)
      expect(response).to have_http_status(200)
      expect(response.body).to include CGI.escapeHTML("Password is not allowed with any white space")
      expect(response.body).to include CGI.escapeHTML("Password confirmation can't be blank")

      expect(User.count).to eq(0)
      post users_path,
        params: { user: {
          name: "dave",
          email: "dave@example.com",
          password: nil,
          password_confirmation: nil
        }}
      expect(User.count).to eq(0)
      expect(response).to have_http_status(200)
      expect(response.body).to include CGI.escapeHTML("Password can't be blank")
      expect(response.body).to include CGI.escapeHTML("Password confirmation can't be blank")
    end
    
    it "dosen't work because of mismatch password" do
      expect(User.count).to eq(0)
      post users_path,
        params: { user: {
          name: "dave",
          email: "dave@example.com",
          password: "dave1234",
          password_confirmation: "dave4321"
        }}
      expect(User.count).to eq(0)
      expect(response).to have_http_status(200)
      expect(response.body).to include CGI.escapeHTML("Password confirmation doesn't match Password")
    end
  end
end
