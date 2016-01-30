class EntrantsEvents < ActiveRecord::Migration
  def change
    create_table :entrants_events, :id => false do |t|
      t.integer :entrant_id
      t.integer :event_id
    end	
  end
end
