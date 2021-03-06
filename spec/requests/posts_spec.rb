require "rails_helper"

RSpec.describe "Posts", type: :request do
  let!(:posts) { create_list(:post, 10) }

  describe "GET /posts" do
    before { get '/posts' }
    
    it 'returns posts' do
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end
end
