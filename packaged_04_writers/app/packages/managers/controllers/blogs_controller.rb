class BlogsController < ApplicationController
  before_action :set_user
  before_action :set_blog, only: %i[ show edit update destroy ]

  # GET /blogs or /blogs.json
  def index
    @blogs = Blog.where(user_id: @user.id)
  end

  # GET /blogs/1 or /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new(user_id: @user.id)
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs or /blogs.json
  def create
    create_params = blog_params.merge(user_id: @user.id)
    @blog = Blog.new(create_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to user_blogs_url(@user), notice: "Blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1 or /blogs/1.json
  def update
    update_params = blog_params.merge(user_id: @user.id)

    respond_to do |format|
      if @blog.update(update_params)
        format.html { redirect_to user_blogs_url(@user), notice: "Blog was successfully updated." }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1 or /blogs/1.json
  def destroy
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to user_blogs_url(@user), notice: "Blog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_blog
    @blog = Blog.find_by(id: params[:id], user_id: @user.id)
  end

  # Only allow a list of trusted parameters through.
  def blog_params
    params.require(:blog).permit(:content, :user_id)
  end
end
