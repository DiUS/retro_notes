class Api::FeedbackSessionsController < Api::BaseController
  skip_authorization_check

  def index
    respond_to do |format|
      format.json { render_for_api :default, json: FeedbackSession.all, root: :feedback_sessions }
    end
  end
 
  def show
    respond_to do |format|
      format.json { render_for_api :default, json: FeedbackSession.find(params[:id])}
    end
  end
 
  def create
    feedback_session = FeedbackSession.new(params[:feedback_session])
    project = Project.find(params[:project_id])

    if project.feedback_sessions << feedback_session
      respond_with :api, feedback_session
    end
  end
 
  def update
    feedback_session = FeedbackSession.find(params[:id])
    respond_with :api, feedback_session.update_attributes(params[:feedback_session])
  end
 
  def destroy
    respond_with :api, FeedbackSession.destroy(params[:id])
  end
end

