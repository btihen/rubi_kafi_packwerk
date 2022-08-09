class PostsController < ApplicationController
  before_action :set_profile
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = Blog.where(user_id: @profile.id)
  end

  def show
  end

  def new
    @post = Blog.new(user_id: @profile.id)
  end

  def edit
  end

  def create
    create_params = post_params.merge(user_id: @profile.id)
    @post = Blog.new(create_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to profile_posts_url(@profile), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    update_params = post_params.merge(user_id: @profile.id)

    respond_to do |format|
      if @post.update(update_params)
        format.html { redirect_to proflie_posts_url(@profile), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to proflie_posts_url(@profile), notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_profile
    @profile = User.find(params[:profile_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Blog.find_by(id: params[:id], user_id: @profile.id)
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:content, :user_id)
  end
end
