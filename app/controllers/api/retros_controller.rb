class Api::RetrosController < Api::BaseController
  skip_authorization_check

  def index
    respond_to do |format|
      format.json { render_for_api :default, json: Retro.all, root: :retros }
    end
  end
 
  def show
    respond_to do |format|
      format.json { render_for_api :default, json: Retro.find(params[:id])}
    end
  end
 
  def create
    retro = Retro.new(params[:retro])
    retro.save
    
    params[:retro]['reflections'].to_s.split(",").each { |name|
      retro.retro_reflections << RetroReflection.new(title: name)
    }
    
    project = Project.find(params[:project_id])

    if project.retros << retro
      respond_with :api, retro
    end
  end
 
  def update
    retro = Retro.find(params[:id])
    respond_with :api, retro.update_attributes(params[:retro])
  end
 
  def destroy
    respond_with :api, Retro.destroy(params[:id])
  end
end

