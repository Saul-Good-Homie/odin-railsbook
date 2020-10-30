class ApplicationController < ActionController::Base
    
    # def new_session_path(scope)
    #     new_user_session_path
    # end

    # def after_sign_in_path_for(resource)
    #     request.env['omniauth.origin'] || root_path
    # end

private


    def require_login
        unless current_user
            redirect_to new_user_session_path
        end
    end
end
