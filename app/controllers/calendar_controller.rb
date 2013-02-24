# encoding: utf-8
class CalendarController < ApplicationController
  
  def index
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)

    @first_day_of_week = 1
    	
    if params[:id].nil? or params[:id].blank?
    	@event_strips = Event.event_strips_for_month(@shown_month, @first_day_of_week)
        @default_worker = 0
    else
    	@worker = Worker.find(params[:id])
    	@event_strips = @worker.events.event_strips_for_month(@shown_month, @first_day_of_week)
        @default_worker = @worker.id
	end

  end
  
end
