class PagesController < ApplicationController
  skip_authorization_check

  def home
  end

  def spa
    render :layout => 'spa'
  end

  def styleguide
    render :layout => 'styleguide'
  end

end
