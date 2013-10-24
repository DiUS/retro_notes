class Api::ProjectsController < Api::BaseController
  skip_authorization_check
  def index
    respond_with :api, Project.all
  end
 
  def show
    respond_with :api, Project.find(params[:id])
  end
 
  def create
    respond_with :api, Project.create(params[:project])
  end
 
  def update
    project = Project.find(params[:id])
    respond_with :api, project.update_attributes(params[:project])
  end
 
  def destroy
    respond_with :api, Project.destroy(params[:id])
  end
end
