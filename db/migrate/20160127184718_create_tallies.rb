class CreateTallies < ActiveRecord::Migration
  def change
    create_table :tallies do |t|
			t.belongs_to :event, index: true
      t.string  :total_time_m
      t.string  :total_time_s
      t.string  :total_time_ms
      t.integer :entrant_tly_id
			t.integer :total_faults
      t.integer :total_points
      t.string  :title
			t.integer	:qualifying_score
			t.integer :qualifying_scores

      t.timestamps null: false
    end
  end
end