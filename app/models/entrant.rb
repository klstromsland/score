class Entrant < ActiveRecord::Base
  has_and_belongs_to_many :events, inverse_of: :entrant
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :idnumber, presence: true
	validates :dog_name, presence: true
	validates :dogidnumber, presence: true
	validates :breed, presence: true
end