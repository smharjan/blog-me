class BlogsController < ApplicationController
    before_action :set_blog, only: [:show, :edit, :update, :destroy]
    before_action :user_authenticated
    def user_authenticated
        if !user_signed_in?
          return redirect_to index_path
        end
    end

    def index
        @blogs = Blog.order("id DESC")
        @user = User.where.not(id: current_user.id)
    end

    def my_blog
        @blogs =  Blog.where(user_id: current_user.id)
    end

    def show
    end

    def new
        @blog = Blog.new
    end

    def edit
    end

    def create
        @blog = Blog.new(blog_params)
        @blog.user_id = current_user.id
    
        respond_to do |format|
          if @blog.save
            format.html { redirect_to myblogs_url, notice: 'Blog was successfully created.' }
            format.json { render :show, status: :created, location: @blog }
          else
            format.html { render :new }
            format.json { render json: @blog.errors, status: :unprocessable_entity }
          end
        end
    end

    def update
        respond_to do |format|
            if @blog.update(blog_params)

            format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
            format.json { render :show, status: :ok, location: @blog }
            else
            format.html { render :edit }
            format.json { render json: @blog.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @blog.destroy
        respond_to do |format|
          format.html { redirect_to myblogs_url, notice: 'Blog was successfully destroyed.' }
          format.json { head :no_content }
        end
    end


    private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
        @blog = Blog.find(params[:id])
    end

    def blog_params
        params.require(:blog).permit(:title, :description, :feature_image, images:[])
      end
    
end
