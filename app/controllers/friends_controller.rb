class FriendsController < ApplicationController
    before_action :authenticate_user!

    def index
        @user = current_user
        @friends = @user.friends
        @requests = @user.requested_friends
        @pending = @user.pending_friends
    end

    def create
        @user = current_user
        @friend = User.find(params[:id])
        @user.friend_request(@friend)
        
        Notification.create(recipient: @friend, actor: current_user, 
            action: "sent a friend request", notifiable: @user)

        redirect_back(fallback_location: root_path)
    end

    def accept
        @user = current_user
        @friend = User.find(params[:id])
        @user.accept_request(@friend)

        Notification.create(recipient: @friend, actor: current_user, 
            action: "accepted your friend request", notifiable: @user)

        redirect_to user_path(@friend)
    end

    def decline
        @user = current_user
        @friend = User.find(params[:id])
        @user.decline_request(@friend)
        redirect_to root_path
    end

    def remove
        @user = current_user
        @friend = User.find(params[:id])
        @user.remove_friend(@friend)
        redirect_to user_path(@friend)
    end

    def block
        @user.block_friend(@friend)
    end

    def unblock
        @user.unblock_friend(friend)
    end


private


end
