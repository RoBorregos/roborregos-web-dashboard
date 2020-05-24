require 'date'
class EventsController < BaseController
  def index
    @events = Event.all 
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
    @event.start_date=@event.start_date.to_date.strftime("%Y/%m/%d")
    @event.end_date=@event.end_date.to_date.strftime("%Y/%m/%d")
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(
      :name,
      :start_date,
      :end_date,
      :description,
      :sponsor_id
    )
  end
end
