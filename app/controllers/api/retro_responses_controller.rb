class Api::RetroResponsesController < Api::BaseController
  skip_authorization_check

  def index
    respond_to do |format|
      format.json { render_for_api :default, json: RetroResponse.all, root: :retro_responses }
    end
  end
 
  def show
    respond_to do |format|
      format.json { render_for_api :default, json: RetroResponse.find(params[:id])}
    end
  end
 
  def create
    retro_response = RetroResponse.new(params[:retro_response])
    retro_reflection = RetroReflection.find(params[:retro_reflection_id])

    if retro_reflection.retro_responses << retro_response
      respond_with :api, retro_response
    end
  end
 
  def update
    retro_response = RetroResponse.find(params[:id])
    respond_with :api, retro_response.update_attributes(params[:retro_response])
  end
 
  def destroy
    respond_with :api, RetroResponse.destroy(params[:id])
  end
end

