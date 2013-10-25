class Api::ProjectRetrosController < Api::BaseController
  skip_authorization_check

  def index
    respond_to do |format|
      format.json { render_for_api :default, json: Retro.where(project_id: params[:project_id]), root: :feedback_sessions}
    end
  end
end

