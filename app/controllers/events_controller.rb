require 'net/http'

class EventsController < ApplicationController
  before_filter :correct_user, only: :destroy
  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    if user_signed_in?
      @event = Event.new(params[:event])
      @event.user_id = current_user.id

      respond_to do |format|
        if @event.save
          format.html { redirect_to @event, notice: 'Event was successfully created.' }
          format.json { render json: @event, status: :created, location: @event }
        else
          format.html { render action: "new" }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    else
         redirect_to new_user_session_path, notice: "You must sign in before creating an event."
    end
   end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])
    if (not user_signed_in? ) or (not current_user.id == @event.user_id)
      redirect_to root_path, notice: "You must sign in as this user to update their event."
    else
      respond_to do |format|
        if @event.update_attributes(params[:event])
          @greeting = "Hello"
          @new_time = @event.time.to_s
          @name = @event.name
          @all_rsvps = Rsvp.where("event_id = ?", @event.id)
          if(@all_rsvps.length > 0)
            @all_rsvps.each do |rsvp|
              @user = User.where("id = ?", rsvp.user_id).first
              s = "sendgrid.com/api/mail.send.json?to=sibnerian%40gmail.com&from=sibnerian%40gmail.com&subject=Hello%20Ian%20Sibner.Your%20event%20is%20now%March%20thirtieth%20twwentyfifteen&text=sentfromsendgrid&api_user=app14249328%40heroku.com&api_key=5lvtybk3"
              s = URI::escape(s)
              uri = URI(s)
              request = Net::HTTP::Get.new(uri.path)

              response = Net::HTTP.new(uri.host,uri.port) do |http|
                http.request(request)
              end

              puts response
            end
          end

          format.html { redirect_to @event, notice: 'Event was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    if (not user_signed_in? ) or (not current_user.id == @event.user_id)
      redirect_to root_path, notice: "You must sign in as this user to update their event."
    else
      @event.destroy


      respond_to do |format|
        format.html { redirect_to root_url, notice: @event.name + " cancelled." }
        format.json { head :no_content }
      end
    end
  end

  def create_rsvp
    @event = Event.find(params[:id])
  if not user_signed_in?
    redirect_to new_user_session_path, notice: "You must sign in to RSVP"
  end

    active_rsvp = Rsvp.new
    active_rsvp.event_id = @event.id
    active_rsvp.user_id = current_user.id
    active_rsvp.save
    redirect_to @event, "You have successfully RSVP'd to " + @event.name
  end

  def delete_rsvp
    @event = Event.find(params[:id])
    if not user_signed_in?
      redirect_to new_user_session_path, notice: "You must sign in to un-RSVP"
    end

    active_rsvp = Rsvp.where("event_id = ? AND user_id = ?", @event.id, current_user.id).first
    active_rsvp.destroy
    redirect_to root_url, notice: "Successfully un-RSVP'd to" + @event.name



  end

  private

    def correct_user
      @event = Event.find_by_id(params[:id])
      if not user_signed_in?
        redirect_to new_user_session_path, notice: "You must sign in, come on."
      end


      if @event.user_id = current_user.id
      if @event.nil?
        redirect_to root_url , notice: "You can't destroy that event"
      end
      end
    end
end
