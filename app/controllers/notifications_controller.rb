class NotificationsController < ApplicationController
    before_action :authenticate_user!

    def index
        @user = current_user
        @notifications = Notification.where(recipient: current_user).unread
        #@notification = Notification.find(params[:id])
        #@actor = User.find(params[id: @notification.actor_id])
    end

    def mark_as_read
        @notification = Notification.find(params[:id])
        @notification.update(read_at: Time.zone.now)
        redirect_to notifications_path
    end


end