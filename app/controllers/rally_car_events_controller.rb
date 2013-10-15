class RallyCarEventsController < ApplicationController
  before_action :set_rally_car_event, only: [:show, :edit, :update, :destroy]

  # GET /rally_car_events
  # GET /rally_car_events.json
  def index
    @rally_car_events = RallyCarEvent.all
  end

  # GET /rally_car_events/1
  # GET /rally_car_events/1.json
  def show
  end

  # GET /rally_car_events/new
  def new
    @rally_car_event = RallyCarEvent.new
  end

  # GET /rally_car_events/1/edit
  def edit
  end

  # POST /rally_car_events
  # POST /rally_car_events.json
  def create
    @rally_car_event = RallyCarEvent.new(rally_car_event_params)

    respond_to do |format|
      if @rally_car_event.save
        format.html { redirect_to @rally_car_event, notice: 'Rally car event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @rally_car_event }
      else
        format.html { render action: 'new' }
        format.json { render json: @rally_car_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rally_car_events/1
  # PATCH/PUT /rally_car_events/1.json
  def update
    respond_to do |format|
      if @rally_car_event.update(rally_car_event_params)
        format.html { redirect_to @rally_car_event, notice: 'Rally car event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rally_car_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rally_car_events/1
  # DELETE /rally_car_events/1.json
  def destroy
    @rally_car_event.destroy
    respond_to do |format|
      format.html { redirect_to rally_car_events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rally_car_event
      @rally_car_event = RallyCarEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rally_car_event_params
      params.require(:rally_car_event).permit(:name, :beginning_on, :end_on, :note)
    end
end
