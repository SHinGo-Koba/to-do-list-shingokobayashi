require 'rails_helper'

RSpec.describe "PostPosts", type: :request do

  describe "POST /posts" do
    let!(:user1){ create(:user) }
    it "works with valid content" do
      login_as(user1)
      expect(user1.reload.posts.count).to eq(0)
      post posts_path,
        params: { post: {
          content: "test"
        }},
        xhr: true
      expect(user1.reload.posts.count).to eq(1)
      puts user1.posts.inspect
    end
    
    it "doesn't work because of no log_in" do
      get signup_path
      expect(user1.reload.posts.count).to eq(0)
      post posts_path,
        params: { post: {
          content: "test1"
        }},
        xhr: true
      expect(user1.reload.posts.count).to eq(0)
      puts user1.posts.inspect
    end
  end
end
