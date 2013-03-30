class Notifications < ActionMailer::Base
  default from: "sibnerian@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.new_game.subject
  #
  def new_game
    @greeting = "Hi"
#    @all_rsvps = Rsvp.where("event_id = ?", event.id)
    #@all_rsvps.each do |rsvp|
     # @user = User.where("id = ?", rsvp.user_id).first
      #mail(:to => @user.email, :from => "sibnerian@gmail.com", :subject => "Event Change")
    #end

    mail to: "to@example.org"
  end

  def send_mail(event)
    @greeting = "Hello"
    @new_time = event.time.to_s
    @name = event.name
    @all_rsvps = Rsvp.where("event_id = ?", event.id)
    if(@all_rsvps.length > 0)
      @all_rsvps.each do |rsvp|
       @user = User.where("id = ?", rsvp.user_id).first
       mail :to => @user.email, :subject => "Event Change"
      end
    end
  end
end
