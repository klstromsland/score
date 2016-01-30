class Tally < ActiveRecord::Base
  belongs_to :event
	validates :qualifying_score, numericality:
	{greater_than_or_equal_to: 0}
	validates :qualifying_scores, numericality:
	{greater_than_or_equal_to: 0}
end