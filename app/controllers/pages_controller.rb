class PagesController < ApplicationController
  before_action :user_authenticated, only: [:index]

  def user_authenticated
    if user_signed_in?
      return redirect_to blogs_path
    end
  end

  def index
  end
  def about
  end

  def user_profile
    @user = User.where(id: current_user.id)
  end
end
