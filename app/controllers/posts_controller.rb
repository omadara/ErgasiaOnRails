class PostsController < ApplicationController
  before_action :check_if_authorized, only: [:edit, :update, :destroy]

  # GET /posts
  def index
    if params[:q].present?
      @posts = Post.search_by_title(params[:q])
      render 'posts/search_result'
    end
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully deleted.'
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:category_id, :title, :body)
    end

    def check_if_authorized
      if Post.find(params[:id]).user_id != current_user.id
        redirect_to posts_url, alert: 'You must be the owner of the post'
      end
    end

end
