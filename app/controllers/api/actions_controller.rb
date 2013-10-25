class Api::ActionsController < Api::BaseController
  skip_authorization_check

  def index
    respond_to do |format|
      format.json { render_for_api :default, json: Action.all, root: :retro_actions }
    end
  end
 
  def show
    respond_to do |format|
      format.json { render_for_api :default, json: Action.find(params[:id])}
    end
  end
 
  def create
    respond_with :api, Action.create(params[:retro_action])
  end
 
  def update
    action = Action.find(params[:id])
    respond_with :api, action.update_attributes(params[:retro_action])
  end
 
  def destroy
    respond_with :api, Action.destroy(params[:id])
  end
end

  