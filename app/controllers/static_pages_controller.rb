class StaticPagesController < ApplicationController
  def home
    @feed_items = Event.paginate(page: params[:page], :per_page => 10, :order => 'created_at desc')
  end

  def about
  end

  def all_events
    @feed_items = Event.paginate(page: params[:page], :per_page => 10, :order => 'created_at desc')
  end
end
