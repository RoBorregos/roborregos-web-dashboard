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
      flash[:error] = t('messages.errors.could_not_save_event')
      redirect_to :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event
    else
      flash[:error] = t('messages.errors.could_not_save_event')
      redirect_to :edit
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
