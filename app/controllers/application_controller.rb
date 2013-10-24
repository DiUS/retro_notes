class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization :unless => :devise_controller?

  before_filter :store_location

  # Store users previous location before signing in
  def store_location
    ignored_controllers = [
      "devise/confirmations",
      "devise/sessions",
      "devise/registrations"
    ]

    ignored_routes = [
      # { controller: 'pages', action: 'home' }
    ]

    # If devise model is not User, then replace :user_return_to with :{devise model}_return_to
    unless ignored_controllers.include?(params[:controller]) || ignored_routes.include?(controller: params[:controller], action: params[:action])
      session[:user_return_to] = request.url
    end
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    unless user_signed_in?
      redirect_to new_user_session_path, :alert => "You should sign in to see if you can view this page! =)"
    else
      redirect_to dashboard_path, :alert => "This page doesn't exist or your don't have permissions to view it."
    end
  end

  def render_404(exception = nil)
    if exception
      logger.info "Rendering 404 with exception: #{exception.message}"
    end

    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

end
