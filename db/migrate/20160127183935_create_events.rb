class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string  :title
			t.string  :division
			t.integer :int_search_areas
			t.integer :veh_search_areas
			t.integer :ext_search_areas
			t.integer :cont_search_areas
			t.integer :elite_search_areas	  
			t.integer :int_hides
			t.integer :veh_hides
			t.integer :ext_hides
			t.integer :cont_hides
			t.integer :elite_hides 
			t.string  :place
			t.date    :date
			t.string  :host
			t.string  :status

      t.timestamps null: false
    end
  end
end
