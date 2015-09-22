class API::EventsController < ApplicationController
  
  # curl request that works on Cloud 9
  #curl -v -H "Accept: application/json" -H "Origin: espn.com" -H "Content-Type: application/json" -X POST -d '{"name":"foobar"}'  $IP:$PORT/api/events
  
  before_filter :set_access_control_headers
  
  skip_before_action :verify_authenticity_token
  
  
  
  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Content-Type'
  end
  
  
  def index
    render nothing: true, status: 200
  end
  
  def create
    registered_application = RegApplication.find_by(url: request.env['HTTP_ORIGIN'])
    if registered_application.present?
      @event = registered_application.events.new(event_params)
      if @event.save
        render json: @event, status: :created
      else
        render json: @event.errors, status: :unprocessible_entity
      end
    else
      render json: "error", status: :unprocessible_entity
    end
    # if there is a registered application
    # log the event with the event params
    # otherwise render unprocessible entity error
  end
  
  
  private
  
  def event_params
    # { name: "event name"}
    params.permit(:name)
  end
  
end