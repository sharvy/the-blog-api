module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: [:show]
    
      # GET /posts
      def index
        @posts = Post.all
        json_response @posts
      end
    
      def create
        @post = Post.create!(post_params)
        json_response(@post, :created)
      end
    
      def show
        json_response @post
      end
    
      private
    
      def post_params
        params.require(:post).permit(:title, :body)
      end
    
      def set_post
        @post = Post.find(params[:id])
      end
    end
    
  end
end
