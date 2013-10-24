class Admin::UsersController < Admin::BaseController
  
  def index
    @users = User.all.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      # format.json { render json: @user } Remember to prevent user private details leaking out here if uncommenting 
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.accessible = :all if current_user.role_greater_or_equal_to? :admin

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to admin_users_url, notice: 'Changes were successfully saved.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
end
