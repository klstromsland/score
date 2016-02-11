module CurrentEvent
	extend ActiveSupport::Concern
	
	private
	
		def set_event
			@event = Event.find(session[:event_id])
    end
end