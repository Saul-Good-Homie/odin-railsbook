class NotificationsController < ApplicationController
    before_action :authenticate_user!

    def index
        @user = current_user
        @notifications = @user.notifications.all.order("created_at DESC")
        #@notification = Notification.find(params[:id])
        #@actor = User.find(params[id: @notification.actor_id])
    end



end