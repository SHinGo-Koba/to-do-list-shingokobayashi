module SessionsHelper
  def login_as(user)
    post login_path,
      params: { session: {
        name: user.name,
        password: user.password
      }}
    expect(response).to have_http_status(302)
    follow_redirect!
    expect(response).to render_template("users/show")
    expect(response.body).to include CGI.escapeHTML("Login successfully")
  end
end

RSpec.configure do |c|
  c.include SessionsHelper
end