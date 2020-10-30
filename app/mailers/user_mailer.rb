class UserMailer < ApplicationMailer
    default from: 'Railsbooks@example.com'

    def welcome_email(user)
        @user = user
        @url  = 'http://example.com/login'
        mail(to: @user.email, subject: 'Welcome to Railsbook, a Facebook clone!')
    end


end
