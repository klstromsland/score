class ScorecardsController < ApplicationController
  before_action :require_user, only: [:index, :edit, :update, :destroy, :create]
  before_action :set_scorecard, only: [:show, :edit, :update, :destroy]

  # GET /scorecards
  # GET /scorecards.json
  def index
    @scorecards = Scorecard.all
  end

  # GET /scorecards/1
  # GET /scorecards/1.json
  def show
		@scorecard = Scorecard.find(params[:id])
  end

  # GET /scorecards/new
  def new
    @scorecard = Scorecard.new
  end

  # GET /scorecards/1/edit
  def edit
		@scorecard = Scorecard.find(params[:id])
  end

  # POST /scorecards
  # POST /scorecards.json
  def create
    @scorecard = Scorecard.new(scorecard_params)
    respond_to do |format|
      if @scorecard.save
        format.html { redirect_to @scorecard, notice: 'Scorecard was successfully created.' }
		format.js   {}
        format.json { render :show, status: :created, location: @scorecard }
      else
        format.html { render :new }
        format.json { render json: @scorecard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scorecards/1
  # PATCH/PUT /scorecards/1.json
  def update
    @scorecard = Scorecard.find(params[:id])
    respond_to do |format|
      if @scorecard.update(scorecard_params)
        format.html { render :edit, notice: 'Scorecard was successfully updated.' }
		format.js   {}
        format.json { render :show, status: :ok, location: @scorecard }
      else
        format.html { render :edit }
        format.json { render json: @scorecard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scorecards/1
  # DELETE /scorecards/1.json
  def destroy
    @scorecard.destroy
    respond_to do |format|
      format.html { redirect_to scorecards_url, notice: 'Scorecard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scorecard
      @scorecard = Scorecard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scorecard_params
      params.require(:scorecard).permit(:name, :element, :search_area, :hides_max, :maxpoint, :maxtime_m, :maxtime_s, :maxtime_ms, :hides_found, :hides_missed, :finish_call, :false_alert_fringe, :timed_out, :time_elapsed_m, :time_elapsed_s, :time_elapsed_ms,  :eliminated_during_search, :dismissed, :excused, :absent, :other_faults_descr, :other_faults_count, :comments, :judge_signature, :pronounced, :total_faults, :total_points,  :event_ids => [], :entrant_ids => [] )
    end
end
