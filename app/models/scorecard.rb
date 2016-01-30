class Scorecard < ActiveRecord::Base
  belongs_to :event
	validates :maxtime_m, presence: true
	validates :maxtime_s, presence: true
end