require "rails_helper"

module Api
  module V1
    RSpec.describe "Posts", type: :request do
      let!(:posts) { create_list(:post, 10) }
      let!(:post_id) { posts.first.id }

      describe "GET /api/v1/posts" do
        before { get "/api/v1/posts" }

        it "returns posts" do
          expect(json).not_to be_empty
        end

        it "returns status code 200" do
          expect(response).to have_http_status(200)
        end
      end

      describe "GET /api/v1/posts/:id" do
        before { get "/api/v1/posts/#{post_id}" }

        context "when the record exist" do
          it "returns the post" do
            expect(json).not_to be_empty
            expect(json["id"]).to eq(post_id)
          end

          it "returns status code 200" do
            expect(response).to have_http_status(200)
          end
        end

        context "when the record does not exist" do
          let(:post_id) { 11 }

          it "returns a not found message" do
            expect(response.body).to match(/Couldn't find/)
          end

          it "returns status code 404" do
            expect(response).to have_http_status(404)
          end
        end
      end

      describe "POST /api/v1/posts" do
        let(:valid_attributes) { { title: "Hello World", body: "Ruby on Rails is awesome!" } }

        context "when the request is valid" do
          before { post "/api/v1/posts", params: { post: valid_attributes } }

          it "returns status code 201" do
            expect(response).to have_http_status(:created)
          end

          it "returns post" do
            expect(json["title"]).to eq(valid_attributes[:title])
          end
        end

        context "when the request is invalid" do
          before { post "/api/v1/posts", params: { post: { title: "Only Title" } } }

          it "returns status code 422" do
            expect(response).to have_http_status(:unprocessable_entity)
          end

          it "returns a validation failure message" do
            expect(response.body).to match(/Validation failed: Body can't be blank/)
          end
        end
      end
    end
  end
end
