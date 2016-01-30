class EventsController < ApplicationController
  before_action :require_user, only: [:index, :edit, :update, :destroy, :create]

	# GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
		@event = Event.find(params[:id])
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
		@event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
		@event = Event.new(event_params)
		@entrants = Entrant.where(:id => params[:team]) 
		@event.entrants << @entrants
		element_types = ["Container", "Exterior", "Interior", "Vehicle", "Elite"]
		num_sc_cards = 0
		# For each entrant selected through "team", create a scorecard for each search area
		@event.entrants.each do |entrant|
			element_types.each do |elmt|
				case elmt
					when "Container"
						num_sc_cards = @event.cont_search_areas
					when "Exterior"
						num_sc_cards = @event.ext_search_areas
					when "Interior"
						num_sc_cards = @event.int_search_areas
					when "Vehicle"
						num_sc_cards = @event.veh_search_areas
					when "Elite"
						num_sc_cards = @event.elite_search_areas					
				end
				if (num_sc_cards != nil)
					for nums in 1..num_sc_cards
						str_tmp = entrant.first_name + " " + entrant.last_name
						@scorecard = Scorecard.new(name: str_tmp, element: elmt, search_area: nums, entrant_scd_id: entrant.id)
						@event.scorecards << @scorecard
					end
				end
			end
			# For each entrant selected through "team", create a tally
			@tally = Tally.new(entrant_tly_id: entrant.id)
			@event.tallies << @tally
		end
		# For each user selected through "user_team", create a user
		@users = User.where(:id => params[:user_team]) 
		@event.users << @users
		respond_to do |format|
			if @event.save
				format.html { redirect_to event_path(@event), notice: 'Event was successfully created.' }
				format.json { render :show, status: :created, location: @event }
			else
				format.html { render :new }
				format.json { render json: @eventinclud.errors, status: :unprocessable_entity }
			end
		end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @event = Event.find(params[:id])
		@entrants = Entrant.where(:id => params[:team])
		sc_count = 0
		entrant_counter = 0
		sa_count = 0
		nums = 0
		element_types = ["Container", "Exterior", "Interior", "Vehicle", "Elite"]
		# For each element, check if changes have been made to search area entries for each entrant and update if needed.
		element_types.each do |elmt|
			case elmt
				when "Container"
					sa_count = @event.cont_search_areas 
				when "Exterior"
					sa_count = @event.ext_search_areas
				when "Interior"
					sa_count = @event.int_search_areas
				when "Vehicle"
					sa_count = @event.veh_search_areas
				when "Elite"
					sa_count = @event.elite_search_areas			
			end
			# For element search area, check if changes have been made to search area entries for each entrant and update if needed.
			sc_count = 0
			@event.entrants.each do |entrant|
				sc_count = 0
				# Count number of scorecards for element for entrant.
				@event.scorecards.each do |scorecard|
					if (scorecard.entrant_scd_id == entrant.id) && (scorecard.element == elmt)
						sc_count += 1
					end
				end
				# For entrant, if scorecard count equals element search area count, no change. Go to next entrant for this search area.
				if sc_count == sa_count
					next
				end
				# For entrant, if scorecard count does not equal element search area count, update.
				# If scorecard count = 0, add first scorecard, increment count, check condition
				if (sc_count == 0) && (sa_count > sc_count)
					str_tmp = entrant.first_name + " " + entrant.last_name
					@scorecard = Scorecard.new(name: str_tmp, element: elmt, search_area: 1, entrant_scd_id: entrant.id)
					@event.scorecards << @scorecard
					sc_count += 1
					if sc_count == sa_count
						next
					end
				end
				if (sc_count > 0) && (sa_count > sc_count)
					# If scorecard count is greater than zero, find after which index (scorecard.search_area)	to add scorecard and add it, increment count, check condition			
					@event.scorecards.each do |scorecard|
						if scorecard.entrant_scd_id == entrant.id
							str_tmp = entrant.first_name + " " + entrant.last_name
							@scorecard = Scorecard.new(name: str_tmp, element: elmt, search_area: scorecard.search_area + 1, entrant_scd_id: entrant.id)
							@event.scorecards << @scorecard
							sc_count += 1
						end
						if sc_count == sa_count
							next
						end
					end
				end
				# If scorecard count is greater than search area count, find a scorecard to delete with index greater than the number of search areas and delete it, deprecate count, check condition.
				if sa_count < sc_count 
					@event.scorecards.each do |scorecard|
						if (scorecard.entrant_scd_id == entrant.id) && (scorecard.search_area > sa_count)
							@event.scorecards.destroy(scorecard)
							sc_count -= 1
						end
						if sc_count == sa_count
							next
						end
					end
				end
			end
		end		
		#Check if changes have been made to entrants selected through "team" and update if needed.		
		#Check if entrant count has changed.
		if (@entrants.length == 0) && (@event.entrants.length > 0)
			@event.entrants.each do |eventrant|
				@event.scorecards.each do |scorecard|
					if scorecard.entrant_scd_id == eventrant.id
						@event.scorecards.destroy(scorecard)
					end
				end
				@event.tallies.each do |tally|
					if tally.entrant_tly_id == eventrant.id
						@event.tallies.destroy(tally)
					end
				end
				@event.entrants.destroy(eventrant)
			end
		elsif (@event.entrants.length == 0) && (@entrants.length > 0)
			@entrants.each do |entrant|
				element_types.each do |elmt|
					case elmt
						when "Container"
							sa_count = @event.cont_search_areas
						when "Exterior"
							sa_count = @event.ext_search_areas
						when "Interior"
							sa_count = @event.int_search_areas
						when "Vehicle"
							sa_count = @event.veh_search_areas
						when "Elite"
							sa_count = @event.elite_search_areas			
					end
					if sa_count >= 0	  
						for nums in 1..sa_count
							str_tmp = entrant.first_name + " " + entrant.last_name
							@scorecard = Scorecard.new(name: str_tmp, element: elmt, search_area: nums, entrant_scd_id: entrant.id)
							@event.scorecards << @scorecard
						end
					end
				end
				@tally = Tally.new(entrant_tly_id: entrant.id)
				@event.tallies << @tally
				@event.entrants << entrant
			end
		elsif (@event.entrants.length > @entrants.length) && (@event.entrants.length != 0)
			entrant_counter = 0
			@event_entrants_tmp = @event.entrants
			@event_entrants_tmp.each do |eventrant|	
				if entrant_counter < @entrants.length
					@entrants.each do |entrant|
						if entrant.id == eventrant.id
							entrant_counter += 1
							break
						else
							@event.scorecards.each do |scorecard|
								if scorecard.entrant_scd_id == eventrant.id
									@event.scorecards.destroy(scorecard)
								end
							end
							@event.tallies.each do |tally|
								if tally.entrant_tly_id == eventrant.id
									@event.tallies.destroy(tally)
								end
							end
							@event.entrants.destroy(eventrant)						
						end
					end
					if @event.entrants.length == @entrants.length
						break
					end
				else
					@event.scorecards.each do |scorecard|
						if scorecard.entrant_scd_id == eventrant.id
							@event.scorecards.destroy(scorecard)
						end
					end
					@event.tallies.each do |tally|
						if tally.entrant_tly_id == eventrant.id
							@event.tallies.destroy(tally)
						end
					end
					@event.entrants.destroy(eventrant)
					if @event.entrants.length == @entrants.length
						break
					end					
				end
			end
		elsif (@event.entrants.length < @entrants.length) && (@entrants.length != 0)
			entrant_counter = 0
			new_entrant_counter = 0
			@event_entrants_tmp = @event.entrants
			#find existing entrants that match new entrants so that can be ignored?
			@entrants.each do |entrant|				
				if entrant_counter < @event_entrants_tmp.length
					@event_entrants_tmp.each do |eventrant|			
						if entrant.id == eventrant.id
							entrant_counter += 1
							new_entrant_counter = 0
							break
						elsif entrant_counter < @event_entrants_tmp.length
							new_entrant_counter += 1
							if new_entrant_counter < @event_entrants_tmp.length
								next
							elsif new_entrant_counter == @event_entrants_tmp.length
								element_types.each do |elmt|
									case elmt
										when "Container"
											sa_count = @event.cont_search_areas
										when "Exterior"
											sa_count = @event.ext_search_areas
										when "Interior"
											sa_count = @event.int_search_areas
										when "Vehicle"
											sa_count = @event.veh_search_areas
										when "Elite"
											sa_count = @event.elite_search_areas			
									end
									if sa_count >= 0	  
										for nums in 1..sa_count
											str_tmp = entrant.first_name + " " + entrant.last_name
											@scorecard = Scorecard.new(name: str_tmp, element: elmt, search_area: nums, entrant_scd_id: entrant.id)
											@event.scorecards << @scorecard
										end
									end
								end
								@tally = Tally.new(entrant_tly_id: entrant.id)
								@event.tallies << @tally
								@event.entrants << entrant
								new_entrant_counter = 0
							end
						end
					end
				elsif @event.entrants.length < @entrants.length
					element_types.each do |elmt|
						case elmt
							when "Container"
								sa_count = @event.cont_search_areas
							when "Exterior"
								sa_count = @event.ext_search_areas
							when "Interior"
								sa_count = @event.int_search_areas
							when "Vehicle"
								sa_count = @event.veh_search_areas
							when "Elite"
								sa_count = @event.elite_search_areas			
						end
						if sa_count >= 0	  
							for nums in 1..sa_count
								str_tmp = entrant.first_name + " " + entrant.last_name
								@scorecard = Scorecard.new(name: str_tmp, element: elmt, search_area: nums, entrant_scd_id: entrant.id)
								@event.scorecards << @scorecard
							end
						end
					end
					@tally = Tally.new(entrant_tly_id: entrant.id)
					@event.tallies << @tally
					@event.entrants << entrant
					if @event.entrants.length == @entrants.length
						break
					end
				end
			end
		elsif (@event.entrants.length == @entrants.length) && (@entrants.length != 0)
		# check if entrant ids have changed
			entrant_counter = 0
			@event_entrants_tmp = @event.entrants
			@event_entrants_tmp.each do |eventrant|
				if entrant_counter == @event_entrants_tmp.length
					break
				end
				@entrants.each do |entrant|			
					if entrant.id == eventrant.id
						entrant_counter += 1
						break
					elsif entrant_counter <= @event_entrants_tmp.length
						next
					else
						@event.scorecards.each do |scorecard|
							if scorecard.entrant_scd_id == eventrant.id
								@event.scorecards.destroy(scorecard)
							end
						end
						@event.tallies.each do |tally|
							if tally.entrant_tly_id == eventrant.id
								@event.tallies.destroy(tally)
							end
						end
						@event.entrants.destroy(eventrant)						
						element_types.each do |elmt|
							case elmt
								when "Container"
									sa_count = @event.cont_search_areas
								when "Exterior"
									sa_count = @event.ext_search_areas
								when "Interior"
									sa_count = @event.int_search_areas
								when "Vehicle"
									sa_count = @event.veh_search_areas
								when "Elite"
									sa_count = @event.elite_search_areas			
							end
							if sa_count >= 0	  
								for nums in 1..sa_count
									str_tmp = entrant.first_name + " " + entrant.last_name
									@scorecard = Scorecard.new(name: str_tmp, element: elmt, search_area: nums, entrant_scd_id: entrant.id)
									@event.scorecards << @scorecard
								end
							end
						end
						@tally = Tally.new(entrant_tly_id: entrant.id)
						@event.tallies << @tally
						@event.entrants << entrant
						entrant_counter += 1
						if entrant_counter == @event_entrants_tmp.length
							break
						end
					end
					if entrant_counter == @event_entrants_tmp.length
						break
					end
				end
			end
		end
		@users = User.where(:id => params[:user_team])
		@event.users.destroy_all
		@event.users << @users
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
		@event = Event.find(params[:id])
		@event.scorecards.destroy_all
		@event.tallies.destroy_all	
		@event.entrants.destroy_all
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
#    def set_event
#      @event = Event.find(params[:id])
#    end

    # Never trust parameters from the scary internet, only allow the white list through.

    def event_params
      params.require(:event).permit( :title, :place, :division, :date, :host, :int_search_areas, :ext_search_areas, :cont_search_areas, :veh_search_areas, :elite_search_areas, :int_hides, :ext_hides, :cont_hides, :veh_hides, :elite_hides, :status, :entrant_ids => [], :scorecard_ids => [], :tally_ids => [], :user_ids => [] )
    end
end