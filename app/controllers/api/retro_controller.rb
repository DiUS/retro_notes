class Api::RetroController < Api::BaseController
  skip_authorization_check

  def index
    respond_to do |format|
      format.json { render_for_api :default, json: RetroSession.all, root: :retros }
    end
  end
 
  def show
    respond_to do |format|
      format.json { render_for_api :default, json: RetroSession.find(params[:id])}
    end
  end
 
  def create
    retro = RetroSession.new(params[:retro])
    project = Project.find(params[:project_id])

    if project.retros << retro
      respond_with :api, retro
    end
  end
 
  def update
    retro = RetroSession.find(params[:id])
    respond_with :api, retro.update_attributes(params[:retro])
  end
 
  def destroy
    respond_with :api, RetroSession.destroy(params[:id])
  end
end

