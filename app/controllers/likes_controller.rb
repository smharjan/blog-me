class LikesController < ApplicationController
    before_action :find_blog
    before_action :find_like, only: [:destroy]

    def create
        if already_liked?
          flash[:notice] = "You can't like more than once"
        else
          @blog.likes.create(user_id: current_user.id)
        end
        redirect_to blog_path(@blog)
    end

    def destroy
        if !(already_liked?)
          flash[:notice] = "Cannot unlike"
        else
          @like.destroy
        end
        redirect_to blog_path(@blog)
    end

    def find_like
        @like = @blog.likes.find(params[:id])
    end

    private
    def find_blog
        @blog = Blog.find(params[:blog_id])
    end

    def already_liked?
        Like.where(user_id: current_user.id, blog_id:
        params[:blog_id]).exists?
    end

end
