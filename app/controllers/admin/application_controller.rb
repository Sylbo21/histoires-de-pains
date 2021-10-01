# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :ensure_authenticated
    before_action :authenticate_admin

    # Why aren't logged_in?, ensure_authenticated and current_user methods available here as they are in main ApplicationController? Why do I have to repeat them here?

    def logged_in?
      session[:user_id].present?
    end

    def ensure_authenticated
      redirect_to login_path unless(logged_in?)
    end

    def current_user
      User.find(session[:user_id])
    end

    def authenticate_admin
      # TODO Add authentication logic here.
      redirect_to(login_path) unless current_user.role == 'admin'
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
  end
end
