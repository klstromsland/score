class CreateScorecards < ActiveRecord::Migration
  def change
    create_table :scorecards do |t|
			t.belongs_to :event, index: true
			t.integer :entrant_scd_id
			t.integer :hides_found
			t.integer :hides_missed
			t.integer :maxpoint
			t.integer :hides_max
			t.integer :other_faults_count
			t.integer :search_area
			t.integer :total_faults
			t.integer :total_points
			t.string  :absent
			t.string  :element
			t.string  :dismissed
			t.string  :eliminated_during_search
			t.string  :excused
			t.integer :false_alert_fringe	  
			t.string  :finish_call
			t.string  :judge_signature
			t.string  :maxtime_m
			t.string  :maxtime_s
			t.string  :maxtime_ms	  	  
			t.string  :name
			t.string  :pronounced
			t.string  :timed_out		  
			t.string  :time_elapsed_m
			t.string  :time_elapsed_s	  
			t.string  :time_elapsed_ms	  
			t.text    :comments	  
			t.text    :other_faults_descr	  

      t.timestamps null: false
    end
  end
end
