class PostsController < ApplicationController

  # GET /posts
  def index
    @posts = Post.all
    json_response @posts
  end
end
