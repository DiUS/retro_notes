class Api::EventsController < Api::BaseController
  skip_authorization_check
  def index
    respond_with :api, Event.all
  end
 
  def show
    respond_with :api, Event.find(params[:id])
  end
 
  def create
    respond_with :api, Event.create(params[:event])
  end
 
  def update
    event = Event.find(params[:id])
    respond_with :api, event.update_attributes(params[:event])
  end
 
  def destroy
    respond_with :api, Event.destroy(params[:id])
  end
end
