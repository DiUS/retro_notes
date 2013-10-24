class DashboardController < ApplicationController

  def index
    authorize! :index, :dashboard
  end
  
end