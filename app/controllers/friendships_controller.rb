class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:show, :edit, :update, :destroy]

  # POST /friendships
  def create
    # Disallow the ability to send friend request more than once to same person
    return if current_user.friends?(User.find(params[:user_id]))
    #don't allow the ability to send friend request to yourself
    return if current_user.id == params[:user_id]

    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to root_url
    else
      flash[:error] = "Unable to add friend."
      redirect_to root_url
    end
  end

  # DELETE /friendships/1
  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to current_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friendship_params
      params.require(:friendship).permit(:user_id, :friend_id, :create, :destroy)
    end
end


