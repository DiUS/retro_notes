class UsersController < ApplicationController
  load_and_authorize_resource


  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb

      # IMPORTANT
      # Remember to prevent user private details leaking out here
      # if uncommenting the below line
      # format.json { render json: @user }
    end
  end
end
