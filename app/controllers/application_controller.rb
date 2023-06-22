class ApplicationController < ActionController::Base
    #before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        #devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :photo])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :photo, :phone, :current_position])
    end

    # def authorize_request(kind = nil) 
    #     unless kind.include?(current_user.role) redirect_to posts_path, notice: "You are not authorized to perform this action" 
    #     end 
    # end

    def after_sign_in_path_for(resource)
        jobs_path
    end

    def authorize_request(kind = nil) 
        if current_user
            unless kind.include?(current_user.role)
                redirect_to jobs_path, notice: "You are not authorized to perform this action" 
            end 
        else
            redirect_to jobs_path, notice: "You are not authorized to perform this action" 
        end
    end
    
end
