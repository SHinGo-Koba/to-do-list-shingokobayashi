require 'rails_helper'

RSpec.describe "PostPosts", type: :request do

  describe "POST /posts" do
    let!(:user1){ create(:user) }
    it "works with valid content" do
      login_as(user1)
      expect(user1.reload.posts.Count).to eq(0)
      post posts_path,
        params: { post: {
          content: "test"
        }}
      expect(user1.reload.posts.Count).to eq(1)
    end
  end
end
