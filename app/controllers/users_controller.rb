class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @post = Post.new
    @posts = @user.posts
  end

  private

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:profile_pic)
  end
  
end

