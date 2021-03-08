require "rails_helper"

RSpec.describe "Posts", type: :request do
  let!(:posts) { create_list(:post, 10) }

  describe "GET /posts" do
    before { get '/posts' }
    
    context 'when records exist' do
      it 'returns posts' do
        expect(json).not_to be_empty
      end
  
      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when records do not exist' do
      let!(:posts) { [] }

      it 'returns empty array' do
        expect(json).to eql([])
      end
    end
  end
end
