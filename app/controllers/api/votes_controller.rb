class Api::VotesController < Api::BaseController
  skip_authorization_check

  def index
    respond_to do |format|
      format.json { render_for_api :default, json: Vote.all, root: :votes }
    end
  end
 
  def show
    respond_to do |format|
      format.json { render_for_api :default, json: Vote.find(params[:id])}
    end
  end
 
  def create
    vote = Vote.new(params[:vote])
    retro_repsonse = RetroResponse.find(params[:retro_repsonse_id])

    if retro_repsonse.votes << vote
      respond_with :api, vote
    end
  end
 
  def update
    vote = Vote.find(params[:id])
    respond_with :api, vote.update_attributes(params[:vote])
  end
 
  def destroy
    respond_with :api, Vote.destroy(params[:id])
  end
end

