class Event < ActiveRecord::Base
  has_and_belongs_to_many :entrants, inverse_of: :event
  has_many :scorecards, dependent: :destroy
  has_many :tallies, dependent: :destroy
  has_and_belongs_to_many :users, inverse_of: :event
	validates :title, presence: true
	validates :division, presence: true
	validates :host, presence: true
	validates :int_search_areas, numericality:
	{greater_than_or_equal_to: 0}
	validates :ext_search_areas, numericality:
	{greater_than_or_equal_to: 0}
	validates :cont_search_areas, numericality:
	{greater_than_or_equal_to: 0}
	validates :veh_search_areas, numericality:
	{greater_than_or_equal_to: 0}
	validates :elite_search_areas, numericality:
	{greater_than_or_equal_to: 0}
	validates :int_hides, numericality:
	{greater_than_or_equal_to: :int_search_areas}
	validates :ext_hides, numericality:
	{greater_than_or_equal_to: :ext_search_areas}
	validates :cont_hides, numericality:
	{greater_than_or_equal_to: :cont_search_areas}
	validates :veh_hides, numericality:
	{greater_than_or_equal_to: :veh_search_areas}
	validates :elite_hides, numericality:
	{greater_than_or_equal_to: :elite_search_areas}	
end