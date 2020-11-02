class RegistrationsController < Devise::RegistrationsController


    def create
        super
        UserMailer.welcome_email(resource).deliver unless resource.invalid?
        @admin = User.find(1)
        @new_user = resource
        @admin.friend_request(@user)
        Notification.create(recipient: @new_user, actor: @admin, 
            action: "sent a friend request", notifiable: @user)
    end

private
    def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile_pic)
    end

    def account_update_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :profile_pic)
    end

end